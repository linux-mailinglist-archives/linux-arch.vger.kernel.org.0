Return-Path: <linux-arch+bounces-8867-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9216E9BDA3B
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 01:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56198284675
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C8E8BEC;
	Wed,  6 Nov 2024 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi90Nqmi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA780B;
	Wed,  6 Nov 2024 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852478; cv=none; b=VN3epaeSFnEur4HhFowND4Gc+Ak+YjBcgZj6GomMNNH+djZUipGuYlgBdeMjd38Zir/X/OvV8qOpJ4JycuykoCK9RegKmTaRP/4XB2ohInXPYKC7UTnt6SZPnBFrUSViADO0HvJThaHTghtdYq64r/o1CyEM0WZnR71yOwhZsEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852478; c=relaxed/simple;
	bh=mOpVnAHe4MqIKwl3ho4VzIbTh1rgs+rTfxjMO/1W1xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASuMkdd2Td4wLD3cdc5O5jztbNCCJqtCbC2FSRY5YXyy1qCf2wiVrRe3MHl4W9EC9jcWIrsz5LJHK5A52MTf8mnSQU8PsiK0KFrMUaITlPfJk5JI1ofwndMsL9GtV2Evh2ue1L81Hb0XxpRkj3b2h8/XC9jkiFH0Qn5q9QXT8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi90Nqmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554FEC4CECF;
	Wed,  6 Nov 2024 00:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730852478;
	bh=mOpVnAHe4MqIKwl3ho4VzIbTh1rgs+rTfxjMO/1W1xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hi90NqmicUHl0bogT/HoDWBZfexn+CAxL/cDiDjsIfWTD35rRTdA0zrAYtOI2lHG4
	 rJqaLlMBUQoaXhCBXT6dOWhRApkhGoCHkw5USQTuVoMoUcINuCYT/R9RTxBMhter9R
	 7HbatxaZ2b1PrvMdoLu53zdRRbq60PU/tz5nLzoPoVzzJ4wghOxHTySL9FLzD5GuRd
	 qaefBbQQ9+cpleJjAZPbvZ/JECZlIFpEORh0rZnyWY8w8ANDLdwcysj4Qr7QU6Z3Wb
	 9ZNNAQvF4f8gNGMpcy6c31rSCmoxfJnwBQQ4q+Q1pL0EURpv3FMwu/kqHrJaJxCyDK
	 k+Ql1amwfUHEQ==
Date: Tue, 5 Nov 2024 16:21:16 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	petr.pavlu@suse.com, da.gomez@samsung.com, masahiroy@kernel.org,
	deller@gmx.de, linux-arch@vger.kernel.org,
	live-patching@vger.kernel.org, kris.van.hees@oracle.com
Subject: Re: [PATCH v3] selftests: add new kallsyms selftests
Message-ID: <Zyq2fMpMGy7SgeYE@bombadil.infradead.org>
References: <20241021193310.2014131-1-mcgrof@kernel.org>
 <CABCJKudob+8GH2U_QLEngjqjOVmDfm8ZkEfn-Ya9ZG5OEOrRtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKudob+8GH2U_QLEngjqjOVmDfm8ZkEfn-Ya9ZG5OEOrRtQ@mail.gmail.com>

On Tue, Oct 29, 2024 at 09:24:30AM -0700, Sami Tolvanen wrote:
> Hi Luis,
> 
> On Mon, Oct 21, 2024 at 12:33 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > diff --git a/lib/tests/module/gen_test_kallsyms.sh b/lib/tests/module/gen_test_kallsyms.sh
> > new file mode 100755
> > index 000000000000..e85f10dc11bd
> > --- /dev/null
> > +++ b/lib/tests/module/gen_test_kallsyms.sh
> > @@ -0,0 +1,128 @@
> [..]
> > +gen_template_module_data_b()
> > +{
> > +       printf "\nextern int auto_test_a_%010d;\n\n" 28
> > +       echo "static int auto_runtime_test(void)"
> > +       echo "{"
> > +       printf "\nreturn auto_test_a_%010d;\n" 28
> > +       echo "}"
> > +}
> 
> FYI, I get a warning when loading test_kallsyms_b because the init
> function return value is >0:

This fixes it.

From b776d662c8e05d67c7879d0f6f5208dd431d900a Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Wed, 6 Nov 2024 00:17:21 +0000
Subject: [PATCH] tests/module/gen_test_kallsyms.sh: use 0 value for variables

Use 0 for the values as we use them for the return value on init
to keep the test modules simple. This fixes a splat reported

do_init_module: 'test_kallsyms_b'->init suspiciously returned 255, it should follow 0/-E convention
do_init_module: loading module anyway...
CPU: 5 UID: 0 PID: 1873 Comm: modprobe Not tainted 6.12.0-rc3+ #4
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-1 09/18/2024
Call Trace:
 <TASK>
 dump_stack_lvl+0x56/0x80
 do_init_module.cold+0x21/0x26
 init_module_from_file+0x88/0xf0
 idempotent_init_module+0x108/0x300
 __x64_sys_finit_module+0x5a/0xb0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f4f3a718839
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff>
RSP: 002b:00007fff97d1a9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055b94001ab90 RCX: 00007f4f3a718839
RDX: 0000000000000000 RSI: 000055b910e68a10 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007f4f3a7f1b20 R09: 000055b94001c5b0
R10: 0000000000000040 R11: 0000000000000246 R12: 000055b910e68a10
R13: 0000000000040000 R14: 000055b94001ad60 R15: 0000000000000000
 </TASK>
do_init_module: 'test_kallsyms_b'->init suspiciously returned 255, it should follow 0/-E convention
do_init_module: loading module anyway...
CPU: 1 UID: 0 PID: 1884 Comm: modprobe Not tainted 6.12.0-rc3+ #4
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-1 09/18/2024
Call Trace:
 <TASK>
 dump_stack_lvl+0x56/0x80
 do_init_module.cold+0x21/0x26
 init_module_from_file+0x88/0xf0
 idempotent_init_module+0x108/0x300
 __x64_sys_finit_module+0x5a/0xb0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7ffaa5d18839

Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/tests/module/gen_test_kallsyms.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tests/module/gen_test_kallsyms.sh b/lib/tests/module/gen_test_kallsyms.sh
index ae5966f1f904..3f2c626350ad 100755
--- a/lib/tests/module/gen_test_kallsyms.sh
+++ b/lib/tests/module/gen_test_kallsyms.sh
@@ -32,7 +32,7 @@ gen_num_syms()
 	PREFIX=$1
 	NUM=$2
 	for i in $(seq 1 $NUM); do
-		printf "int auto_test_%s_%010d = 0xff;\n" $PREFIX $i
+		printf "int auto_test_%s_%010d = 0;\n" $PREFIX $i
 		printf "EXPORT_SYMBOL_GPL(auto_test_%s_%010d);\n" $PREFIX $i
 	done
 	echo
-- 
2.45.2


