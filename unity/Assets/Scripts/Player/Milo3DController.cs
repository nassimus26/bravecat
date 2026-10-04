using UnityEngine;

namespace Bravecat.Player
{
    /// <summary>
    /// Unity 3D Character Controller for Milo the Cat Warrior
    /// Handles 3D movement, rotation, jumping, and dodge rolling.
    /// </summary>
    [RequireComponent(typeof(CharacterController))]
    public class Milo3DController : MonoBehaviour
    {
        [Header("Movement Settings")]
        public float moveSpeed = 6.0f;
        public float rotationSpeed = 720.0f;
        public float jumpHeight = 2.0f;
        public float gravity = -19.6f;

        [Header("Combat References")]
        public Transform katanaBlade;
        public ParticleSystem slashParticleFX;

        private CharacterController _controller;
        private Vector3 _velocity;
        private bool _isGrounded;

        private void Start()
        {
            _controller = GetComponent<CharacterController>();
        }

        private void Update()
        {
            _isGrounded = _controller.isGrounded;
            if (_isGrounded && _velocity.y < 0)
            {
                _velocity.y = -2.0f;
            }

            // Input Read (Virtual Joystick / WASD)
            float moveX = Input.GetAxis("Horizontal");
            float moveZ = Input.GetAxis("Vertical");

            Vector3 moveDirection = new Vector3(moveX, 0, moveZ).normalized;

            if (moveDirection.magnitude >= 0.1f)
            {
                // Smooth Rotation
                Quaternion targetRotation = Quaternion.LookRotation(moveDirection);
                transform.rotation = Quaternion.RotateTowards(transform.rotation, targetRotation, rotationSpeed * Time.deltaTime);

                // Move Character
                _controller.Move(moveDirection * moveSpeed * Time.deltaTime);
            }

            // Gravity & Jump
            if (Input.GetButtonDown("Jump") && _isGrounded)
            {
                _velocity.y = Mathf.Sqrt(jumpHeight * -2.0f * gravity);
            }

            _velocity.y += gravity * Time.deltaTime;
            _controller.Move(_velocity * Time.deltaTime);
        }
    }
}
