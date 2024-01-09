Return-Path: <linux-arch+bounces-1321-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A9828FA4
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 23:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5A51C24F73
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 22:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8C3EA7B;
	Tue,  9 Jan 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwd91x1d"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670B93E49C;
	Tue,  9 Jan 2024 22:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65911C43390;
	Tue,  9 Jan 2024 22:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704838611;
	bh=eFscEoCIAi+UJQp3abWYRAO4Lvaf4O8cRgQlKNDdBDE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nwd91x1dNBtR27yxcFd0vdX2R91nFh2sr80+T1Mley6qHjF9tzWrlj+ePeAo1JxtU
	 RFKB15XZuN5KBaRz2C6VCT+zmSkveQn0//sEnRFTjDrpc8G2xk1iEig4yLS1YZxODy
	 MztA4vPoFh+YfBSThZU3Cefn1qUWqpIXYsT+3h4BD/D9Z4XcykFVPnQHPTSnDk+c0a
	 l8CGJMFEWrx3nPPssuHkDAE0VyoU8A8AQHggWOiYyx4MtNFkQj1aUFMGSVnGeFiqMB
	 wfJ4l9Qx1nnSBv4gDTiq/c49JAKkmfyVXJOtWB+P5Lgy9qzOBHRvY8UJbKeZCFUsc2
	 uuqtHzBFSfbxA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 09 Jan 2024 15:16:29 -0700
Subject: [PATCH 1/3] selftests/bpf: Update LLVM Phabricator links
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240109-update-llvm-links-v1-1-eb09b59db071@kernel.org>
References: <20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org>
In-Reply-To: <20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org>
To: akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, patches@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linux-arch@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, bridge@lists.linux.dev, 
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, mykolal@fb.com, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7587; i=nathan@kernel.org;
 h=from:subject:message-id; bh=eFscEoCIAi+UJQp3abWYRAO4Lvaf4O8cRgQlKNDdBDE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlzj15IUNPmFinNmNO40TyB+eHTwFMf6kVvPC5Rrjn6Z
 JdC/PJtHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiwu8YGVbUeWkdrFi1UUdq
 4sron76zUsq4BZg2/XauNjb4rF67R4iR4W11UIPnynvJDpfc96myPrzLNvclj2HuZymRz+4ctQ5
 n2AA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

reviews.llvm.org was LLVM's Phabricator instances for code review. It
has been abandoned in favor of GitHub pull requests. While the majority
of links in the kernel sources still work because of the work Fangrui
has done turning the dynamic Phabricator instance into a static archive,
there are some issues with that work, so preemptively convert all the
links in the kernel sources to point to the commit on GitHub.

Most of the commits have the corresponding differential review link in
the commit message itself so there should not be any loss of fidelity in
the relevant information.

Additionally, fix a typo in the xdpwall.c print ("LLMV" -> "LLVM") while
in the area.

Link: https://discourse.llvm.org/t/update-on-github-pull-requests/71540/172
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: ast@kernel.org
Cc: daniel@iogearbox.net
Cc: andrii@kernel.org
Cc: mykolal@fb.com
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/bpf/README.rst             | 32 +++++++++++-----------
 tools/testing/selftests/bpf/prog_tests/xdpwall.c   |  2 +-
 .../selftests/bpf/progs/test_core_reloc_type_id.c  |  2 +-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index cb9b95702ac6..b9a493f66557 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -115,7 +115,7 @@ the insn 20 undoes map_value addition. It is currently impossible for the
 verifier to understand such speculative pointer arithmetic.
 Hence `this patch`__ addresses it on the compiler side. It was committed on llvm 12.
 
-__ https://reviews.llvm.org/D85570
+__ https://github.com/llvm/llvm-project/commit/ddf1864ace484035e3cde5e83b3a31ac81e059c6
 
 The corresponding C code
 
@@ -165,7 +165,7 @@ This is due to a llvm BPF backend bug. `The fix`__
 has been pushed to llvm 10.x release branch and will be
 available in 10.0.1. The patch is available in llvm 11.0.0 trunk.
 
-__  https://reviews.llvm.org/D78466
+__  https://github.com/llvm/llvm-project/commit/3cb7e7bf959dcd3b8080986c62e10a75c7af43f0
 
 bpf_verif_scale/loop6.bpf.o test failure with Clang 12
 ======================================================
@@ -204,7 +204,7 @@ r5(w5) is eventually saved on stack at insn #24 for later use.
 This cause later verifier failure. The bug has been `fixed`__ in
 Clang 13.
 
-__  https://reviews.llvm.org/D97479
+__  https://github.com/llvm/llvm-project/commit/1959ead525b8830cc8a345f45e1c3ef9902d3229
 
 BPF CO-RE-based tests and Clang version
 =======================================
@@ -221,11 +221,11 @@ failures:
 - __builtin_btf_type_id() [0_, 1_, 2_];
 - __builtin_preserve_type_info(), __builtin_preserve_enum_value() [3_, 4_].
 
-.. _0: https://reviews.llvm.org/D74572
-.. _1: https://reviews.llvm.org/D74668
-.. _2: https://reviews.llvm.org/D85174
-.. _3: https://reviews.llvm.org/D83878
-.. _4: https://reviews.llvm.org/D83242
+.. _0: https://github.com/llvm/llvm-project/commit/6b01b465388b204d543da3cf49efd6080db094a9
+.. _1: https://github.com/llvm/llvm-project/commit/072cde03aaa13a2c57acf62d79876bf79aa1919f
+.. _2: https://github.com/llvm/llvm-project/commit/00602ee7ef0bf6c68d690a2bd729c12b95c95c99
+.. _3: https://github.com/llvm/llvm-project/commit/6d218b4adb093ff2e9764febbbc89f429412006c
+.. _4: https://github.com/llvm/llvm-project/commit/6d6750696400e7ce988d66a1a00e1d0cb32815f8
 
 Floating-point tests and Clang version
 ======================================
@@ -234,7 +234,7 @@ Certain selftests, e.g. core_reloc, require support for the floating-point
 types, which was introduced in `Clang 13`__. The older Clang versions will
 either crash when compiling these tests, or generate an incorrect BTF.
 
-__  https://reviews.llvm.org/D83289
+__  https://github.com/llvm/llvm-project/commit/a7137b238a07d9399d3ae96c0b461571bd5aa8b2
 
 Kernel function call test and Clang version
 ===========================================
@@ -248,7 +248,7 @@ Without it, the error from compiling bpf selftests looks like:
 
   libbpf: failed to find BTF for extern 'tcp_slow_start' [25] section: -2
 
-__ https://reviews.llvm.org/D93563
+__ https://github.com/llvm/llvm-project/commit/886f9ff53155075bd5f1e994f17b85d1e1b7470c
 
 btf_tag test and Clang version
 ==============================
@@ -264,8 +264,8 @@ Without them, the btf_tag selftest will be skipped and you will observe:
 
   #<test_num> btf_tag:SKIP
 
-.. _0: https://reviews.llvm.org/D111588
-.. _1: https://reviews.llvm.org/D111199
+.. _0: https://github.com/llvm/llvm-project/commit/a162b67c98066218d0d00aa13b99afb95d9bb5e6
+.. _1: https://github.com/llvm/llvm-project/commit/3466e00716e12e32fdb100e3fcfca5c2b3e8d784
 
 Clang dependencies for static linking tests
 ===========================================
@@ -274,7 +274,7 @@ linked_vars, linked_maps, and linked_funcs tests depend on `Clang fix`__ to
 generate valid BTF information for weak variables. Please make sure you use
 Clang that contains the fix.
 
-__ https://reviews.llvm.org/D100362
+__ https://github.com/llvm/llvm-project/commit/968292cb93198442138128d850fd54dc7edc0035
 
 Clang relocation changes
 ========================
@@ -292,7 +292,7 @@ Here, ``type 2`` refers to new relocation type ``R_BPF_64_ABS64``.
 To fix this issue, user newer libbpf.
 
 .. Links
-.. _clang reloc patch: https://reviews.llvm.org/D102712
+.. _clang reloc patch: https://github.com/llvm/llvm-project/commit/6a2ea84600ba4bd3b2733bd8f08f5115eb32164b
 .. _kernel llvm reloc: /Documentation/bpf/llvm_reloc.rst
 
 Clang dependencies for the u32 spill test (xdpwall)
@@ -304,6 +304,6 @@ from running test_progs will look like:
 
 .. code-block:: console
 
-  test_xdpwall:FAIL:Does LLVM have https://reviews.llvm.org/D109073? unexpected error: -4007
+  test_xdpwall:FAIL:Does LLVM have https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d5? unexpected error: -4007
 
-__ https://reviews.llvm.org/D109073
+__ https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d
diff --git a/tools/testing/selftests/bpf/prog_tests/xdpwall.c b/tools/testing/selftests/bpf/prog_tests/xdpwall.c
index f3927829a55a..4599154c8e9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdpwall.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdpwall.c
@@ -9,7 +9,7 @@ void test_xdpwall(void)
 	struct xdpwall *skel;
 
 	skel = xdpwall__open_and_load();
-	ASSERT_OK_PTR(skel, "Does LLMV have https://reviews.llvm.org/D109073?");
+	ASSERT_OK_PTR(skel, "Does LLVM have https://github.com/llvm/llvm-project/commit/ea72b0319d7b0f0c2fcf41d121afa5d031b319d5?");
 
 	xdpwall__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_type_id.c b/tools/testing/selftests/bpf/progs/test_core_reloc_type_id.c
index 22aba3f6e344..6fc8b9d66e34 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_type_id.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_type_id.c
@@ -80,7 +80,7 @@ int test_core_type_id(void *ctx)
 	 * to detect whether this test has to be executed, however strange
 	 * that might look like.
 	 *
-	 *   [0] https://reviews.llvm.org/D85174
+	 *   [0] https://github.com/llvm/llvm-project/commit/00602ee7ef0bf6c68d690a2bd729c12b95c95c99
 	 */
 #if __has_builtin(__builtin_preserve_type_info)
 	struct core_reloc_type_id_output *out = (void *)&data.out;

-- 
2.43.0


