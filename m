Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D234B31AC
	for <lists+linux-arch@lfdr.de>; Sat, 12 Feb 2022 01:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354317AbiBLAIV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 19:08:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbiBLAIU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 19:08:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0334FD6C;
        Fri, 11 Feb 2022 16:08:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 938DCB82DAF;
        Sat, 12 Feb 2022 00:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0B3C340EB;
        Sat, 12 Feb 2022 00:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644624495;
        bh=gqdzFF5kDLCMBodiKxmUXermGyRjGnle42YGkTQN5Vk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=hlvSQbFrQxmDi6X7OgKXY8erSLYZBXiMp+3RUvAs7zi4JkYDwT3AmnwmkI1jGS+do
         +6sQsyUTdFs3KMziR4RfqebJt1M8+M7wRerkve3HULwvaaUWs5rlIBScv/7w9JQXjN
         +0gRs5gfN9P/Cpkx1oKGa6eHg6INKwdQy4pz1CN9kl52D36Oos4vcD/PFGbiksNNVF
         fea1HmbbGEnQ2huCyuzPscWrNhyxl4pY1uFgxglLQ14LMZDUVv5BNEpiTjy2jN3Q/A
         cjq81L4qtwIqS6JFA92ICb5x211+Zc/Zox4kcJ/5XL6QMQVb4ryHhAFrtXc1Z0DXGN
         MoCcRY3Ly+RFg==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id EC30227C0054;
        Fri, 11 Feb 2022 19:08:12 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Fri, 11 Feb 2022 19:08:13 -0500
X-ME-Sender: <xms:a_oGYgwa4D5i40GkdLZ4lYZRoyiMzNPIl0OjZdqUT0FcaniXX8DTSg>
    <xme:a_oGYkT7189vqZqdWqF1GwDgv8ejA-4v16IpFncHbnwRXRE1b5Z6vkE2sCQiuObhY
    icTlxeeWpqDWrEKosY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieeggddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleffgfef
    vdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheei
    fedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrd
    hluhhtohdruhhs
X-ME-Proxy: <xmx:a_oGYiVsxRyMbHP6WWe9Mmb7CW5XTDc69817MQ0QPhMccaCxaOy0Sw>
    <xmx:a_oGYui1N6w-eR5QH0dzLhbNb0-U7o4GF28nICiDKwfG6FL9G9AT6w>
    <xmx:a_oGYiCoSn_5wq5Yl-3Z8DmjBdpjv0pBuVE0lMdBlauNLBLuGv2puA>
    <xmx:bPoGYqjUoNqnHPW34NGJHtEKMOJFgidrVqV10HKxw_d-U1Jbez6_FfVM6q8>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D415E21E006E; Fri, 11 Feb 2022 19:08:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4748-g31a5b5f50e-fm-cal2020-20220204.001-g31a5b5f5
Mime-Version: 1.0
Message-Id: <4eeab037-502c-4d8d-84da-e29203dad6ad@www.fastmail.com>
In-Reply-To: <e2586482-dfba-2752-0247-7b8dfe95d7fe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-26-rick.p.edgecombe@intel.com>
 <e2586482-dfba-2752-0247-7b8dfe95d7fe@intel.com>
Date:   Fri, 11 Feb 2022 16:07:51 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Balbir Singh" <bsingharora@gmail.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Cyrill Gorcunov" <gorcunov@gmail.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, "Jann Horn" <jannh@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Kees Cook" <keescook@chromium.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Oleg Nesterov" <oleg@redhat.com>, "Pavel Machek" <pavel@ucw.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "Eranian, Stephane" <eranian@google.com>
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 25/35] x86/cet/shstk: Add user-mode shadow stack support
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Fri, Feb 11, 2022, at 3:37 PM, Dave Hansen wrote:
> On 1/30/22 13:18, Rick Edgecombe wrote:
>> Add the user shadow stack MSRs to the xsave helpers, so they can be used
>> to implement the functionality.
>
> Do these MSRs ever affect kernel-mode operation?
>
> If so, we might need to switch them more aggressively at context-switch
> time like PKRU.
>
> If not, they can continue to be context-switched with the PASID state
> which does not affect kernel-mode operation.

PASID?  PASID is all kinds of weird.  I assume you mean switching it with all the normal state.

>
> Either way, it would be nice to have some changelog material to that effect.
