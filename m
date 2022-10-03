Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186885F3978
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 01:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJCXAm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 19:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJCXAk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 19:00:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD40828E38;
        Mon,  3 Oct 2022 16:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57B1061203;
        Mon,  3 Oct 2022 23:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96D1C433D6;
        Mon,  3 Oct 2022 23:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664838038;
        bh=Xkf3Bl/hAOuHkGitFzqAuKe/IKE2LWmGABmXb5OtS5M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ikeZ4d26/rwOgesKbWVRO5wEoNTErR8LHHqKYkqW75cxZ1L3X1Wb7zX/m+V6jJeE5
         +Ylgz6sIK59ufis/31nPNEZNAlekaVtR2zkRw0CkCRZfy4bsRk13JFNkkc+KwAThhO
         dtLyV/4iJdS90xMYqz8adnepkLgDq0kshRpG7ibCfhF+6myF9Sw5/XSgAYM0S6xWnM
         8u3rQxFXCbyuj8fPOkeWedRr29AfZkUcrIANSNqteraG/IJaRnXbOq/BpC15Be5x2N
         xoxdEknCqggH1GgSRCv2U0DT26v+pHt8w2QDOXtx20ulLrlZyp40wK3sgdsTmjOO+4
         r8WWRvahIoE2A==
Message-ID: <6ea0841f-5086-9569-028b-922ec01a9196@kernel.org>
Date:   Mon, 3 Oct 2022 16:00:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 29/39] x86/cet/shstk: Support wrss for userspace
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
 <20220929222936.14584-30-rick.p.edgecombe@intel.com>
 <202210031525.78F3FA8@keescook>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <202210031525.78F3FA8@keescook>
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

On 10/3/22 15:28, Kees Cook wrote:
> On Thu, Sep 29, 2022 at 03:29:26PM -0700, Rick Edgecombe wrote:
>> For the current shadow stack implementation, shadow stacks contents easily
>> be arbitrarily provisioned with data.
> 
> I can't parse this sentence.
> 
>> This property helps apps protect
>> themselves better, but also restricts any potential apps that may want to
>> do exotic things at the expense of a little security.
> 
> Is anything using this right now? Wouldn't thing be safer without WRSS?
> (Why can't we skip this patch?)
> 

So that people don't write programs that need either (shstk off) or 
(shstk on and WRSS on) and crash or otherwise fail on kernels that 
support shstk but don't support WRSS, perhaps?
