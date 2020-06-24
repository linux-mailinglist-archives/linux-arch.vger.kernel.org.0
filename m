Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F86D207D35
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406411AbgFXUdD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406385AbgFXUdC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED83C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c3so3489034ybi.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zJgCLl2NhOgZBqIPJZhtZ4TPiUfcQmmxIv/fzhpa6kU=;
        b=vIahDq7aqL96yiIpIepm/3ftBU8lrk2hUmV84VfhySVdQjCUeRR+npewyO02VLNg1H
         EKz3O7JTeZ12pduy22CiakNubOk5eUICY6CzRnZZ+sqjK5BZ+Ey/hYmxL252W/v3Vw3R
         QHQ+BsLn7Dhzl+5iipLN1+5H5sMa2z5svyVXJRQKvxVQctYxW6ebqQJ3ULghYqVLE/mE
         +epm6jN27/TjGyvgv03OaZPqY9SJiFtufPYwDQq2nbQ/suFkEhepQpQYZtjqOKH1NZDA
         RhrCSfZCiizO3jsUHNb/S1nkjOMbYcBzY5F4xXLc6roRSQybnwlsVEFxN2n39HcU9fzE
         6+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zJgCLl2NhOgZBqIPJZhtZ4TPiUfcQmmxIv/fzhpa6kU=;
        b=g47QPmRfy9gFjNbzNqDVMdO1/881sk+wd1J7HreyqJ1193NFSabk+POUcpOaZl8Fge
         PlIIcteb5trDRq7eUpM3dJCgE9q8YhWtFqEVErYBkVgHnavyRKmO7lDG1elR8rgyzAse
         oQKla3gLgDWTbffIml0D5U3F9AKhdf0aK9sKN/RUwpMw8jc0mxBxjZi9TposbCibKyQ0
         29imDYrhFBhae65GOiFJui/8FuFO/rRlXyr/CaZYaF9amiUc1xx7qbGqzaEQMVRQeBkU
         5zs4oSy1Esh48fK7Ws97vfjws09VMYvPLFbf4R8HDeZKFU4chBFBk+JkV5i4YsNiH+9W
         Ctpw==
X-Gm-Message-State: AOAM532aOK6jT+lj8LQ2CgvctfuamKrRaGS8vBuIZOKWG5kZLvdEMOoi
        tdrCx0NfgRltp0ZCir2xC42XyryJE0IO9kE3ZZI=
X-Google-Smtp-Source: ABdhPJwtupmBRpPe049uS/8X19V10xLMzevhQMzdrNMrqBVJvPzK6fkgs/2PZX+Qd9dpa9Rprg1LfaTpoC6sBdC1f/k=
X-Received: by 2002:a25:7386:: with SMTP id o128mr46698757ybc.266.1593030779834;
 Wed, 24 Jun 2020 13:32:59 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:41 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 03/22] kbuild: lto: fix module versioning
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_MODVERSIONS, version information is linked into each
compilation unit that exports symbols. With LTO, we cannot use this
method as all C code is compiled into LLVM bitcode instead. This
change collects symbol versions into .symversions files and merges
them in link-vmlinux.sh where they are all linked into vmlinux.o at
the same time.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 .gitignore               |  1 +
 Makefile                 |  3 ++-
 arch/Kconfig             |  1 -
 scripts/Makefile.build   | 33 +++++++++++++++++++++++++++++++--
 scripts/Makefile.modpost |  2 ++
 scripts/link-vmlinux.sh  | 25 ++++++++++++++++++++++++-
 6 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index 87b9dd8a163b..51b02c2f2826 100644
--- a/.gitignore
+++ b/.gitignore
@@ -41,6 +41,7 @@
 *.so.dbg
 *.su
 *.symtypes
+*.symversions
 *.tab.[ch]
 *.tar
 *.xz
diff --git a/Makefile b/Makefile
index 0c7fe6fb2143..161ad0d1f77f 100644
--- a/Makefile
+++ b/Makefile
@@ -1793,7 +1793,8 @@ clean: $(clean-dirs)
 		-o -name '.tmp_*.o.*' \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
-		-o -name '*.gcno' \) -type f -print | xargs rm -f
+		-o -name '*.gcno' \
+		-o -name '*.*.symversions' \) -type f -print | xargs rm -f
 
 # Generate tags for editors
 # ---------------------------------------------------------------------------
diff --git a/arch/Kconfig b/arch/Kconfig
index e00b122293f8..87488fe1e6b8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -600,7 +600,6 @@ config LTO_CLANG
 	depends on ARCH_SUPPORTS_LTO_CLANG
 	depends on !FTRACE_MCOUNT_RECORD
 	depends on !KASAN
-	depends on !MODVERSIONS
 	select LTO
 	help
           This option enables Clang's Link Time Optimization (LTO), which
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f307e708a1b7..5c0bbb6ddfcf 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -163,6 +163,15 @@ ifdef CONFIG_MODVERSIONS
 #   the actual value of the checksum generated by genksyms
 # o remove .tmp_<file>.o to <file>.o
 
+ifdef CONFIG_LTO_CLANG
+# Generate .o.symversions files for each .o with exported symbols, and link these
+# to the kernel and/or modules at the end.
+cmd_modversions_c =								\
+	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
+		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
+		    > $@.symversions;						\
+	fi;
+else
 cmd_modversions_c =								\
 	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
 		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
@@ -174,6 +183,7 @@ cmd_modversions_c =								\
 		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
 	fi
 endif
+endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
 ifndef CC_USING_RECORD_MCOUNT
@@ -389,6 +399,18 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 $(subdir-builtin): $(obj)/%/built-in.a: $(obj)/% ;
 $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
 
+# combine symversions for later processing
+quiet_cmd_update_lto_symversions = SYMVER  $@
+ifeq ($(CONFIG_LTO_CLANG) $(CONFIG_MODVERSIONS),y y)
+      cmd_update_lto_symversions =					\
+	rm -f $@.symversions						\
+	$(foreach n, $(filter-out FORCE,$^),				\
+		$(if $(wildcard $(n).symversions),			\
+			; cat $(n).symversions >> $@.symversions))
+else
+      cmd_update_lto_symversions = echo >/dev/null
+endif
+
 #
 # Rule to compile a set of .o files into one .a file (without symbol table)
 #
@@ -396,8 +418,11 @@ $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
 quiet_cmd_ar_builtin = AR      $@
       cmd_ar_builtin = rm -f $@; $(AR) cDPrST $@ $(real-prereqs)
 
+quiet_cmd_ar_and_symver = AR      $@
+      cmd_ar_and_symver = $(cmd_update_lto_symversions); $(cmd_ar_builtin)
+
 $(obj)/built-in.a: $(real-obj-y) FORCE
-	$(call if_changed,ar_builtin)
+	$(call if_changed,ar_and_symver)
 
 #
 # Rule to create modules.order file
@@ -417,8 +442,11 @@ $(obj)/modules.order: $(obj-m) FORCE
 #
 # Rule to compile a set of .o files into one .a file (with symbol table)
 #
+quiet_cmd_ar_lib = AR      $@
+      cmd_ar_lib = $(cmd_update_lto_symversions); $(cmd_ar)
+
 $(obj)/lib.a: $(lib-y) FORCE
-	$(call if_changed,ar)
+	$(call if_changed,ar_lib)
 
 # NOTE:
 # Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
@@ -427,6 +455,7 @@ $(obj)/lib.a: $(lib-y) FORCE
 ifdef CONFIG_LTO_CLANG
 quiet_cmd_link_multi-m = AR [M]  $@
 cmd_link_multi-m =						\
+	$(cmd_update_lto_symversions);				\
 	rm -f $@; 						\
 	$(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(filter %.o,$^)
 else
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 9ced8aecd579..42dbdc2bbf73 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -110,6 +110,8 @@ prelink-ext = .lto
 quiet_cmd_cc_lto_link_modules = LTO [M] $@
 cmd_cc_lto_link_modules =						\
 	$(LD) $(ld_flags) -r -o $@					\
+		$(shell [ -s $(@:.lto.o=.o.symversions) ] &&		\
+			echo -T $(@:.lto.o=.o.symversions))		\
 		--whole-archive $(filter-out FORCE,$^)
 
 %.lto.o: %.o FORCE
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a681b3b6722e..69a6d7254e28 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -39,11 +39,28 @@ info()
 	fi
 }
 
+# If CONFIG_LTO_CLANG is selected, collect generated symbol versions into
+# .tmp_symversions.lds
+gen_symversions()
+{
+	info GEN .tmp_symversions.lds
+	rm -f .tmp_symversions.lds
+
+	for a in ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}; do
+		for o in $(${AR} t $a 2>/dev/null); do
+			if [ -f ${o}.symversions ]; then
+				cat ${o}.symversions >> .tmp_symversions.lds
+			fi
+		done
+	done
+}
+
 # Link of vmlinux.o used for section mismatch analysis
 # ${1} output file
 modpost_link()
 {
 	local objects
+	local lds=""
 
 	objects="--whole-archive				\
 		${KBUILD_VMLINUX_OBJS}				\
@@ -53,6 +70,11 @@ modpost_link()
 		--end-group"
 
 	if [ -n "${CONFIG_LTO_CLANG}" ]; then
+		if [ -n "${CONFIG_MODVERSIONS}" ]; then
+			gen_symversions
+			lds="${lds} -T .tmp_symversions.lds"
+		fi
+
 		# This might take a while, so indicate that we're doing
 		# an LTO link
 		info LTO ${1}
@@ -60,7 +82,7 @@ modpost_link()
 		info LD ${1}
 	fi
 
-	${LD} ${KBUILD_LDFLAGS} -r -o ${1} ${objects}
+	${LD} ${KBUILD_LDFLAGS} -r -o ${1} ${lds} ${objects}
 }
 
 objtool_link()
@@ -238,6 +260,7 @@ cleanup()
 {
 	rm -f .btf.*
 	rm -f .tmp_System.map
+	rm -f .tmp_symversions.lds
 	rm -f .tmp_vmlinux*
 	rm -f System.map
 	rm -f vmlinux
-- 
2.27.0.212.ge8ba1cc988-goog

