Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17E9295428
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506108AbgJUV2D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 17:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2505544AbgJUV2D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 17:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603315681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=npHB1hy+ohfvs54PXo0mWCyiDRitVB3e4369uMWtO3E=;
        b=J76nDGVIukA6uMeyl3dsBnuKUJyI8WyhAwV4xrdXkcLuC2XZHHEzh0pozoXIsdru68hxNA
        fW4nBvQ7V5TeDZOrf1PEK+bR3f44uYbwrfX3nthM4l8RWYszlBQ+CRJRJIXhsn+SnBKfZN
        rjWsxBtqH70UpNb7BcyeYUbcdqr+jTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-YOTFvTwkO0i9giCn_eXxEQ-1; Wed, 21 Oct 2020 17:27:57 -0400
X-MC-Unique: YOTFvTwkO0i9giCn_eXxEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C48045708C;
        Wed, 21 Oct 2020 21:27:54 +0000 (UTC)
Received: from treble (ovpn-115-237.rdu2.redhat.com [10.10.115.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 799F855760;
        Wed, 21 Oct 2020 21:27:50 +0000 (UTC)
Date:   Wed, 21 Oct 2020 16:27:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
Message-ID: <20201021212747.ofk74lugt4hhjdzg@treble>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com>
 <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
 <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
 <20201021093213.GV2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021093213.GV2651@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 11:32:13AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 21, 2020 at 10:56:06AM +0200, Peter Zijlstra wrote:
> 
> > I do not see these in particular, although I do see a lot of:
> > 
> >   "sibling call from callable instruction with modified stack frame"
> 
> defconfig-build/vmlinux.o: warning: objtool: msr_write()+0x10a: sibling call from callable instruction with modified stack frame
> defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x99: (branch)
> defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x3e: (branch)
> defconfig-build/vmlinux.o: warning: objtool:   msr_write()+0x0: <=== (sym)
> 
> $ nm defconfig-build/vmlinux.o | grep msr_write
> 0000000000043250 t msr_write
> 00000000004289c0 T msr_write
> 0000000000003056 t msr_write.cold
> 
> Below 'fixes' it. So this is also caused by duplicate symbols.

There's a new linker flag for renaming duplicates:

  https://sourceware.org/bugzilla/show_bug.cgi?id=26391

But I guess that doesn't help us now.

I don't have access to GCC 10 at the moment so I can't recreate it.
Does this fix it?

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e1d7460574b..aecdf25b2381 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -217,11 +217,14 @@ struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 	return NULL;
 }
 
+#define for_each_possible_sym(elf, name, sym)				\
+	elf_hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
+
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name)
 {
 	struct symbol *sym;
 
-	elf_hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
+	for_each_possible_sym(elf, name, sym)
 		if (!strcmp(sym->name, name))
 			return sym;
 
@@ -432,6 +435,8 @@ static int read_symbols(struct elf *elf)
 		list_for_each_entry(sym, &sec->symbol_list, list) {
 			char pname[MAX_NAME_LEN + 1];
 			size_t pnamelen;
+			struct symbol *psym;
+
 			if (sym->type != STT_FUNC)
 				continue;
 
@@ -454,8 +459,14 @@ static int read_symbols(struct elf *elf)
 
 			strncpy(pname, sym->name, pnamelen);
 			pname[pnamelen] = '\0';
-			pfunc = find_symbol_by_name(elf, pname);
-
+			pfunc = NULL;
+			for_each_possible_sym(elf, pname, psym) {
+				if ((!psym->cfunc || psym->cfunc == psym) &&
+				    !strcmp(psym->name, pname)) {
+					pfunc = psym;
+					break;
+				}
+			}
 			if (!pfunc) {
 				WARN("%s(): can't find parent function",
 				     sym->name);

