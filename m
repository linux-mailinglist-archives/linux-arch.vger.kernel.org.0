Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F295F39C4
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJCXWB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJCXVm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:21:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BD12AE2F;
        Mon,  3 Oct 2022 16:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89363B8167C;
        Mon,  3 Oct 2022 23:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E7FC433D6;
        Mon,  3 Oct 2022 23:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664839288;
        bh=yamzuIFFkRskLclSUhT79/xfr8FDVLCU37aEmswN37Y=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=XVgO/DyUkp+jUFZzaWodSpcYO30efmUyxWXqEfnBsgqWN6brv8pRGUZn6JxSO//TS
         rB+zrBuc7mbAJ5O9vl49m51WMIvxHPnKgwc+qvmyddipHTn1d3EJI9TCQ/TNegKh4O
         BEu8x1CK5szkrXo6GQXkpLZZTp9iI5b2V/MAplaeSmlhlc13Sj4DcZUyxQadlstEl+
         dGCSuIlxRVhuxm2LOgNilLzmrOranFb/RSTMrWJ5/wSial2F5GDp7iQz2yIVAOpdiJ
         v8eVK+Ic+Pc0vPaRtZmrA64t42M0M5DevU3YbNWzEPNi5WGfqe2t975WruwfOU5PLi
         X8Y9j91CYOeIg==
Message-ID: <ed5f3a95-2854-8b36-7ed9-f1d7ad0a2e51@kernel.org>
Date:   Mon, 3 Oct 2022 16:21:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [OPTIONAL/RFC v2 39/39] x86: Add alt shadow stack support
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-40-rick.p.edgecombe@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220929222936.14584-40-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/29/22 15:29, Rick Edgecombe wrote:
> To handle stack overflows, applications can register a separate signal alt
> stack to use for the stack to handle signals. To handle shadow stack
> overflows the kernel can similarly provide the ability to have an alt
> shadow stack.


The overall SHSTK mechanism has a concept of a shadow stack that is 
valid and not in use and a shadow stack that is in use.  This is used, 
for example, by RSTORSSP.  I would like to imagine that this serves a 
real purpose (presumably preventing two different threads from using the 
same shadow stack and thus corrupting each others' state).

So maybe altshstk should use exactly the same mechanism.  Either signal 
delivery should do the atomic very-and-mark-busy routine or registering 
the stack as an altstack should do it.

I think your patch has this maybe 1/3 implemented, but I don't see any 
atomics, and you seem to have removed (?) the code that actually 
modifies the token on the stack.

>   
> +static bool on_alt_shstk(unsigned long ssp)
> +{
> +	unsigned long alt_ss_start = current->thread.sas_shstk_sp;
> +	unsigned long alt_ss_end = alt_ss_start + current->thread.sas_shstk_size;
> +
> +	return ssp >= alt_ss_start && ssp < alt_ss_end;
> +}

We're forcing AUTODISARM behavior (right?), so I don't think this is 
needed at all.  User code is never "on the alt stack".  It's either "on 
the alt stack but the alt stack is disarmed, so it's not on the alt 
stack" or it's just straight up not on the alt stack.
