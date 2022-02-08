Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE04AD3AB
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 09:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351246AbiBHIla (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 03:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350981AbiBHIlL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 03:41:11 -0500
X-Greylist: delayed 167 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 00:41:08 PST
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662ADC0401F6;
        Tue,  8 Feb 2022 00:41:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644309666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+It4P3xPoeH5J/e9lA7VjY28XpNcFDRoZRHbbjMbu5U=;
        b=FMUUbamEpDp9Twu7NkDpbKNalho/IRBoc5L5fW5X+KyAlt7aQ9D0z0Lepxl4pVat9hEh6M
        pFCNv+ciIZAdbt5WZnVwcbgYfcUkeU4Yo+9/EdyaF8auAQnV0fIYvDdpwRxx9no4FdLc5w
        c95kK+H3Lf8rIw9jp4zdT0QB1GmDQCeec9dq4ok1tc+kWoNkWCOJcxI5UB2YwvfpbmEXnK
        9zo5yjhU2lQmzw49yC7HhrmaegQT9oSRI/0m08jBTFK9S+JvZVS7vmwGtaz2MU1Pyws3+w
        AUtH0FFTBLTv1OQRrLTBw3hgbOTCrkziqylp282nVqOUvvOxntVKWHmJ7Dxh/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644309666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+It4P3xPoeH5J/e9lA7VjY28XpNcFDRoZRHbbjMbu5U=;
        b=7uifLMqFDvP10anvdiJQ9zvhl249BUxbV/w40H0HuQ5ADnPZLqP2GPkJNDpnQGgrLnrBAa
        MA8hB6MQm3fWwaCg==
To:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 02/35] x86/cet/shstk: Add Kconfig option for Shadow Stack
In-Reply-To: <248ef880-025d-54ce-f3ce-fed0e50a0445@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-3-rick.p.edgecombe@intel.com>
 <248ef880-025d-54ce-f3ce-fed0e50a0445@intel.com>
Date:   Tue, 08 Feb 2022 09:41:06 +0100
Message-ID: <87sfstvjh9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 07 2022 at 14:39, Dave Hansen wrote:

> On 1/30/22 13:18, Rick Edgecombe wrote:
>> +config X86_SHADOW_STACK
>> +	prompt "Intel Shadow Stack"
>> +	def_bool n
>> +	depends on AS_WRUSS
>> +	depends on ARCH_HAS_SHADOW_STACK
>> +	select ARCH_USES_HIGH_VMA_FLAGS
>> +	help
>> +	  Shadow Stack protection is a hardware feature that detects function
>> +	  return address corruption.  This helps mitigate ROP attacks.
>> +	  Applications must be enabled to use it, and old userspace does not
>> +	  get protection "for free".
>> +	  Support for this feature is present on Tiger Lake family of
>> +	  processors released in 2020 or later.  Enabling this feature
>> +	  increases kernel text size by 3.7 KB.
>
> I guess the "2020" comment is still OK.  But, given that it's on AMD and
> a could of other Intel models, maybe we should just leave this at:
>
> 	CPUs supporting shadow stacks were first released in 2020.

Yes.

> If we say anything.  We mostly want folks to just go read the
> documentation if they needs more details.

Also the kernel text size increase blurb is pretty useless as that's a
number which is wrong from day one.

Thanks,

        tglx
