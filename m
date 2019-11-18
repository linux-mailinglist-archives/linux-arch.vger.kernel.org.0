Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F212100A00
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2019 18:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKRRNo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Nov 2019 12:13:44 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:47408 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRRNo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2019 12:13:44 -0500
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iWkas-0003iP-CR; Mon, 18 Nov 2019 17:13:42 +0000
Subject: Re: [PATCH] ELF: warn if process starts with executable stack
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        security@kernel.org
References: <20191118145114.GA9228@avx2>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <1981366e-93d7-79bd-749f-d5d08d689a52@codethink.co.uk>
Date:   Mon, 18 Nov 2019 17:13:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118145114.GA9228@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18/11/2019 14:51, Alexey Dobriyan wrote:
> PT_GNU_STACK is fail open design, at least warn people that something
> isn't right.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>   fs/exec.c |    7 +++++++
>   1 file changed, 7 insertions(+)
> 
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -762,6 +762,13 @@ int setup_arg_pages(struct linux_binprm *bprm,
>   		goto out_unlock;
>   	BUG_ON(prev != vma);
>   

it might be worth to use:
  if (IS_ENABLED(CONFIG_MMU) && vm_flags & VM_EXEC) {

instead of the #ifdef


> +#ifdef CONFIG_MMU
> +	if (vm_flags & VM_EXEC) {
> +		pr_warn_once("process '%s'/%u started with executable stack\n",
> +			     current->comm, current->pid);
> +	}
> +#endif
> +
>   	/* Move stack pages down in memory. */
>   	if (stack_shift) {
>   		ret = shift_arg_pages(vma, stack_shift);
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
