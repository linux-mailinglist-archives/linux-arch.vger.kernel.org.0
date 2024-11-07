Return-Path: <linux-arch+bounces-8915-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A979C11DC
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 23:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3051F215CD
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD77219C87;
	Thu,  7 Nov 2024 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLLQjJsu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54825218D99;
	Thu,  7 Nov 2024 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018802; cv=none; b=aHruMmd+MH/rZLqN3xAwYBqGQx5Lni9l2XUFPc922Mi0bgscmiGTFFfLL8fh1MKyexJEu/4bahVCiU7oGjz7xw0c6XzAbIyaJSFzA3bojXmN7otFn0IGaQpLEgRozkeuR91sl6q5hC2luBpDQ3hOFGvZZRgPGoUV9r6xetzsBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018802; c=relaxed/simple;
	bh=u+y+ZgnzSc1JBFX0IBWulkzQvEr1r5XByDl3smbKDig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH2mBDl5BTKXdwrd1LMPLHbdOQIPXnUwMIqWoWdeYqFyqZm2ARSrtC5b8UadztfmtGgO3EdYwKSqqqS2lxzdDrgrXpWxhh9E9ntYceQRn9YN+0b+FF6kCplwFdSHBpKAkBELyMzoVBxgh22JPeZAFIJuO03A/QpcuNPlfCIMd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLLQjJsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8044CC4CECC;
	Thu,  7 Nov 2024 22:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731018801;
	bh=u+y+ZgnzSc1JBFX0IBWulkzQvEr1r5XByDl3smbKDig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLLQjJsu9fyqP8yzMFHBWd5h5WM1jNHoZXNwdDGFgsG3Vd7u1wj2XANhEwRes0GWU
	 YoqCc5J+/7r2hYKc7JR/ZtEn3JeqA2orhLEFcZAVUcBGyMmMMLnGgE5XM70EFeu3Gw
	 iktSCrppCV7agn9jxuD6YN2xxrMiHZFiJbxWqp9/jkbGQPRuh9ukrdBuSZXnFxBLVy
	 sG/cngVuAEsKTbwAG0+n4rb7Q1DS7r/+IHP0nmK2dxQd19hyIhDqf1HlooLqcCOPb1
	 L0WUD0s2uP7NirQbhLF3So9usIuX3ReuVM9bJ25Owkey9CxcdazXidspl1yWJTv2ss
	 0lKimBvWDHZBQ==
Date: Thu, 7 Nov 2024 14:33:20 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	petr.pavlu@suse.com, da.gomez@samsung.com, masahiroy@kernel.org,
	deller@gmx.de, linux-arch@vger.kernel.org,
	live-patching@vger.kernel.org, kris.van.hees@oracle.com
Subject: Re: [PATCH] tests/module/gen_test_kallsyms.sh: use 0 value for
 variables
Message-ID: <Zy1AMPMYfE5tKJYz@bombadil.infradead.org>
References: <20241106002401.283517-1-mcgrof@kernel.org>
 <CABCJKueDJuAz30=Wat5D1-V9eYzAbP7wAY61Fgzw_KZJcHWiSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKueDJuAz30=Wat5D1-V9eYzAbP7wAY61Fgzw_KZJcHWiSw@mail.gmail.com>

On Wed, Nov 06, 2024 at 06:46:48PM +0000, Sami Tolvanen wrote:
> Hi Luis,
> 
> On Wed, Nov 6, 2024 at 12:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Use 0 for the values as we use them for the return value on init
> > to keep the test modules simple. This fixes a splat reported
> >
> > do_init_module: 'test_kallsyms_b'->init suspiciously returned 255, it should follow 0/-E convention
> > do_init_module: loading module anyway...
> > CPU: 5 UID: 0 PID: 1873 Comm: modprobe Not tainted 6.12.0-rc3+ #4
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-1 09/18/2024
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x56/0x80
> >  do_init_module.cold+0x21/0x26
> >  init_module_from_file+0x88/0xf0
> >  idempotent_init_module+0x108/0x300
> >  __x64_sys_finit_module+0x5a/0xb0
> >  do_syscall_64+0x4b/0x110
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x7f4f3a718839
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff>
> > RSP: 002b:00007fff97d1a9e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> > RAX: ffffffffffffffda RBX: 000055b94001ab90 RCX: 00007f4f3a718839
> > RDX: 0000000000000000 RSI: 000055b910e68a10 RDI: 0000000000000004
> > RBP: 0000000000000000 R08: 00007f4f3a7f1b20 R09: 000055b94001c5b0
> > R10: 0000000000000040 R11: 0000000000000246 R12: 000055b910e68a10
> > R13: 0000000000040000 R14: 000055b94001ad60 R15: 0000000000000000
> >  </TASK>
> > do_init_module: 'test_kallsyms_b'->init suspiciously returned 255, it should follow 0/-E convention
> > do_init_module: loading module anyway...
> > CPU: 1 UID: 0 PID: 1884 Comm: modprobe Not tainted 6.12.0-rc3+ #4
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.08-1 09/18/2024
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x56/0x80
> >  do_init_module.cold+0x21/0x26
> >  init_module_from_file+0x88/0xf0
> >  idempotent_init_module+0x108/0x300
> >  __x64_sys_finit_module+0x5a/0xb0
> >  do_syscall_64+0x4b/0x110
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x7ffaa5d18839
> >
> > Reported-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  lib/tests/module/gen_test_kallsyms.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/tests/module/gen_test_kallsyms.sh b/lib/tests/module/gen_test_kallsyms.sh
> > index ae5966f1f904..3f2c626350ad 100755
> > --- a/lib/tests/module/gen_test_kallsyms.sh
> > +++ b/lib/tests/module/gen_test_kallsyms.sh
> > @@ -32,7 +32,7 @@ gen_num_syms()
> >         PREFIX=$1
> >         NUM=$2
> >         for i in $(seq 1 $NUM); do
> > -               printf "int auto_test_%s_%010d = 0xff;\n" $PREFIX $i
> > +               printf "int auto_test_%s_%010d = 0;\n" $PREFIX $i
> >                 printf "EXPORT_SYMBOL_GPL(auto_test_%s_%010d);\n" $PREFIX $i
> >         done
> >         echo
> 
> Looks good to me. Thanks!
> 
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Merged, thanks.

  Luis

