Return-Path: <linux-arch+bounces-4219-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 915078BCF40
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914A3B27FFA
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E8385C52;
	Mon,  6 May 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qncIOQlu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCA85953;
	Mon,  6 May 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002587; cv=none; b=IuGERdwaAUYQJdAq0rWaZj7UZyWsJScNSTFZNE4bWnbvSnVx9c4mKsAsr5/Hkt1mdoa1LqVo8A96lw4PW+nh6PZ49Q3kHvMnQftg2Hd1roh54yK4D8rR3pbDUG0oK31ntUbgWIQI4NDNAoct4FfL8kUmHkFgoIj+eILeqJboLJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002587; c=relaxed/simple;
	bh=UJcPiw61xTI0GeGTdwGeKs1FkrZi0wwoWTT0pSrYn+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7PhHZRoE1r+kzlqDLINQOaErh6pRALvsCcVIpa7u7A4QWVyaW0P5w0bK9l67DKOzOqtiqVgcLH8T9Wq7gasos0YcweFRUNEgm6T7X4p9Aa3cwDQNVuLcWV1tEGKsXvJ4gCur8bCWjo7aLl5JVCl7oZS+2ooEPER99Didpv2tfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qncIOQlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47029C3277B;
	Mon,  6 May 2024 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002587;
	bh=UJcPiw61xTI0GeGTdwGeKs1FkrZi0wwoWTT0pSrYn+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qncIOQluY79Qw/5vK9cuYeOsaeGHZWh5iJhlSkuk0AhFlvx45q904/jFgmewC0dO/
	 sDlStiO5wtvFfCRPsmb6qFR5cC071gHejIJL3F2J40kGO/nwipqAiPx+/m4MAkNLwc
	 OaG7V6t0ERjpn+D4wekF0Uck7O6G01DVI7lTslvjuWfY+miffm9Vq9EdikZgHyK+6e
	 Z/VOsswwuhyK4HKJXkE4sq75FMe3gRYzZDsuJ1fP4kZ8qvB3/IarrRJi92bHwlPE5f
	 GAvNvqbUOZcMYT5zsaj/A68h9wy1SxFdd7cjqoB2mUCMp55DeUSeWEwOBBssbi9TTi
	 cmyYgz0UKQ6zw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] kbuild: provide reasonable defaults for tool coverage
Date: Mon,  6 May 2024 22:35:42 +0900
Message-Id: <20240506133544.2861555-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506133544.2861555-1-masahiroy@kernel.org>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The objtool, sanitizers (KASAN, UBSAN, etc.), and profilers (GCOV, etc.)
are intended for kernel space objects. To exclude objects from their
coverage, you need to set variables such as OBJECT_FILES_NON_STNDARD=y,
KASAN_SANITIZE=n, etc.

For instance, the following are not kernel objects, and therefore should
opt out of coverage:

  - vDSO
  - purgatory
  - bootloader (arch/*/boot/)

Kbuild can detect these cases without relying on such variables because
objects not directly linked to vmlinux or modules are considered
"non-standard objects".

Detecting objects linked to vmlinux or modules is straightforward:

  - objects added to obj-y are linked to vmlinux
  - objects added to lib-y are linked to vmlinux
  - objects added to obj-m are linked to modules

In the past, there was yet another case:

  - object paths added to head-y were linked to vmlinux

Commit ce697ccee1a8 ("kbuild: remove head-y syntax") eliminated this.

There are still some exceptions. For example, arch/s390/boot/Makefile
needlessly uses obj-y for the bootloader objects, which can be fixed
later.

Going forward, objects that are not listed in obj-y, lib-y, or obj-m
will opt out of objtool, sanitizers, and profilers by default.

You can still override the Kbuild decision by explicitly specifying
OBJECT_FILES_NON_STANDARD, KASAN_SANITIZE, etc. but most of such Make
variables can be removed.

The next commit will clean up redundant variables.

Note:

The coverage for some objects will be changed:

  - exclude .vmlinux.export.o from UBSAN, KCOV
  - exclude arch/csky/kernel/vdso/vgettimeofday.o from UBSAN
  - exclude arch/parisc/kernel/vdso32/vdso32.so from UBSAN
  - exclude arch/parisc/kernel/vdso64/vdso64.so from UBSAN
  - exclude arch/x86/um/vdso/um_vdso.o from UBSAN
  - exclude drivers/misc/lkdtm/rodata.o from UBSAN, KCOV
  - exclude init/version-timestamp.o from UBSAN, KCOV
  - exclude lib/test_fortify/*.o from all santizers and profilers

I believe these are positive effects.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build |  2 +-
 scripts/Makefile.lib   | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c9c07a6144eb..56bacd992a09 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -214,7 +214,7 @@ endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
 
-is-standard-object = $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(target-stem).o)$(OBJECT_FILES_NON_STANDARD)n),y)
+is-standard-object = $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(target-stem).o)$(OBJECT_FILES_NON_STANDARD)n),$(is-kernel-object))
 
 $(obj)/%.o: private objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5972ec4ee29b..d3180182af47 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -154,7 +154,7 @@ _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(target-stem).lds)
 #
 ifeq ($(CONFIG_GCOV_KERNEL),y)
 _c_flags += $(if $(patsubst n%,, \
-		$(GCOV_PROFILE_$(target-stem).o)$(GCOV_PROFILE)$(CONFIG_GCOV_PROFILE_ALL)), \
+		$(GCOV_PROFILE_$(target-stem).o)$(GCOV_PROFILE)$(if $(is-kernel-object),$(CONFIG_GCOV_PROFILE_ALL))), \
 		$(CFLAGS_GCOV))
 endif
 
@@ -165,32 +165,32 @@ endif
 ifeq ($(CONFIG_KASAN),y)
 ifneq ($(CONFIG_KASAN_HW_TAGS),y)
 _c_flags += $(if $(patsubst n%,, \
-		$(KASAN_SANITIZE_$(target-stem).o)$(KASAN_SANITIZE)y), \
+		$(KASAN_SANITIZE_$(target-stem).o)$(KASAN_SANITIZE)$(is-kernel-object)), \
 		$(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
 endif
 endif
 
 ifeq ($(CONFIG_KMSAN),y)
 _c_flags += $(if $(patsubst n%,, \
-		$(KMSAN_SANITIZE_$(target-stem).o)$(KMSAN_SANITIZE)y), \
+		$(KMSAN_SANITIZE_$(target-stem).o)$(KMSAN_SANITIZE)$(is-kernel-object)), \
 		$(CFLAGS_KMSAN))
 _c_flags += $(if $(patsubst n%,, \
-		$(KMSAN_ENABLE_CHECKS_$(target-stem).o)$(KMSAN_ENABLE_CHECKS)y), \
+		$(KMSAN_ENABLE_CHECKS_$(target-stem).o)$(KMSAN_ENABLE_CHECKS)$(is-kernel-object)), \
 		, -mllvm -msan-disable-checks=1)
 endif
 
 ifeq ($(CONFIG_UBSAN),y)
 _c_flags += $(if $(patsubst n%,, \
-		$(UBSAN_SANITIZE_$(target-stem).o)$(UBSAN_SANITIZE)y), \
+		$(UBSAN_SANITIZE_$(target-stem).o)$(UBSAN_SANITIZE)$(is-kernel-object)), \
 		$(CFLAGS_UBSAN))
 _c_flags += $(if $(patsubst n%,, \
-		$(UBSAN_SIGNED_WRAP_$(target-stem).o)$(UBSAN_SANITIZE_$(target-stem).o)$(UBSAN_SIGNED_WRAP)$(UBSAN_SANITIZE)y), \
+		$(UBSAN_SIGNED_WRAP_$(target-stem).o)$(UBSAN_SANITIZE_$(target-stem).o)$(UBSAN_SIGNED_WRAP)$(UBSAN_SANITIZE)$(is-kernel-object)), \
 		$(CFLAGS_UBSAN_SIGNED_WRAP))
 endif
 
 ifeq ($(CONFIG_KCOV),y)
 _c_flags += $(if $(patsubst n%,, \
-	$(KCOV_INSTRUMENT_$(target-stem).o)$(KCOV_INSTRUMENT)$(CONFIG_KCOV_INSTRUMENT_ALL)), \
+	$(KCOV_INSTRUMENT_$(target-stem).o)$(KCOV_INSTRUMENT)$(if $(is-kernel-object),$(CONFIG_KCOV_INSTRUMENT_ALL))), \
 	$(CFLAGS_KCOV))
 endif
 
@@ -200,7 +200,7 @@ endif
 #
 ifeq ($(CONFIG_KCSAN),y)
 _c_flags += $(if $(patsubst n%,, \
-	$(KCSAN_SANITIZE_$(target-stem).o)$(KCSAN_SANITIZE)y), \
+	$(KCSAN_SANITIZE_$(target-stem).o)$(KCSAN_SANITIZE)$(is-kernel-object)), \
 	$(CFLAGS_KCSAN))
 # Some uninstrumented files provide implied barriers required to avoid false
 # positives: set KCSAN_INSTRUMENT_BARRIERS for barrier instrumentation only.
@@ -219,6 +219,10 @@ _cpp_flags += $(addprefix -I, $(src) $(obj))
 endif
 endif
 
+# If $(is-kernel-object) is 'y', this object will be linked to vmlinux or modules
+is-kernel-object = $(or $(part-of-builtin),$(part-of-module))
+
+part-of-builtin = $(if $(filter $(basename $@).o, $(real-obj-y) $(lib-y)),y)
 part-of-module = $(if $(filter $(basename $@).o, $(real-obj-m)),y)
 quiet_modtag = $(if $(part-of-module),[M],   )
 
-- 
2.40.1


