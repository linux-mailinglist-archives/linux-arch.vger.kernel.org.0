Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7D93D9C77
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 06:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhG2EFm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 29 Jul 2021 00:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhG2EFl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jul 2021 00:05:41 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE976101C;
        Thu, 29 Jul 2021 04:05:37 +0000 (UTC)
Date:   Thu, 29 Jul 2021 00:05:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <mingo@redhat.com>, <davem@davemloft.net>, <ast@kernel.org>,
        <ryabinin.a.a@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] kallsyms: Rename is_kernel() and
 is_kernel_text()
Message-ID: <20210729000531.7c4da1f1@oasis.local.home>
In-Reply-To: <1551f9cc-eaf8-efef-0590-e2549eebe4ae@huawei.com>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
        <20210728081320.20394-6-wangkefeng.wang@huawei.com>
        <20210728112836.289865f5@oasis.local.home>
        <1551f9cc-eaf8-efef-0590-e2549eebe4ae@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 29 Jul 2021 10:00:51 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> On 2021/7/28 23:28, Steven Rostedt wrote:
> > On Wed, 28 Jul 2021 16:13:18 +0800
> > Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >  
> >> The is_kernel[_text]() function check the address whether or not
> >> in kernel[_text] ranges, also they will check the address whether
> >> or not in gate area, so use better name.  
> > Do you know what a gate area is?
> >
> > Because I believe gate area is kernel text, so the rename just makes it
> > redundant and more confusing.  
> 
> Yes, the gate area(eg, vectors part on ARM32, similar on x86/ia64) is 
> kernel text.
> 
> I want to keep the 'basic' section boundaries check, which only check 
> the start/end
> 
> of sections, all in section.h,  could we use 'generic' or 'basic' or 
> 'core' in the naming?
> 
>   * is_kernel_generic_data()	--- come from core_kernel_data() in kernel.h
>   * is_kernel_generic_text()
> 
> The old helper could remain unchanged, any suggestion, thanks.

Because it looks like the check of just being in the range of "_stext"
to "_end" is just an internal helper, why not do what we do all over
the kernel, and just prefix the function with a couple of underscores,
that denote that it's internal?

  __is_kernel_text()

Then you have:

 static inline int is_kernel_text(unsigned long addr)
 {
	if (__is_kernel_text(addr))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }

-- Steve
