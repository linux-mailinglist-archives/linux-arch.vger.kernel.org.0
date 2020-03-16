Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3504186681
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 09:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgCPIaq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 04:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729994AbgCPIap (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 04:30:45 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A472820658;
        Mon, 16 Mar 2020 08:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584347444;
        bh=ShtIzAXjdARpIp5bk6R+u6x5+mPatLQqVE+H2TFyyiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iljvpBfjN2QMpa+akkgow4BQCj7qUXZxzO9BNLKJqukhpSaF5nQwMPp3dEN9PjoW1
         3gBXFXuJUC19uMMOg7vzlyRrTuBNqoC9X/18UiBS5+4VMORwfPLMuJEm2R95vdqD7y
         wfoZd+uoGkyYhgnoSQySBYoJXMMLSO29tEYXU0Pk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jDl91-00D1aD-0w; Mon, 16 Mar 2020 08:30:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Mar 2020 08:30:42 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, olaf@aepfle.de,
        Andy Whitcroft <apw@canonical.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jason Wang <jasowang@redhat.com>, marcelo.cerri@canonical.com,
        "K. Y. Srinivasan" <kys@microsoft.com>, sunilmut@microsoft.com,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
In-Reply-To: <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
Message-ID: <632eb459dbe53a9b69df2a4f030a755b@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: arnd@arndb.de, mikelley@microsoft.com, will@kernel.org, ardb@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com, jasowang@redhat.com, marcelo.cerri@canonical.com, kys@microsoft.com, sunilmut@microsoft.com, boqun.feng@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-03-16 08:22, Arnd Bergmann wrote:
> On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> 
> wrote:
>>  /*
>> + * Functions for allocating and freeing memory with size and
>> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
>> + * the guest page size may not be the same as the Hyper-V page
>> + * size. We depend upon kmalloc() aligning power-of-two size
>> + * allocations to the allocation size boundary, so that the
>> + * allocated memory appears to Hyper-V as a page of the size
>> + * it expects.
>> + *
>> + * These functions are used by arm64 specific code as well as
>> + * arch independent Hyper-V drivers.
>> + */
>> +
>> +void *hv_alloc_hyperv_page(void)
>> +{
>> +       BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
>> +       return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
>> +}
>> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> 
> I don't think there is any guarantee that kmalloc() returns 
> page-aligned
> allocations in general.

I believe that guarantee came with 59bb47985c1db ("mm, sl[aou]b: 
guarantee
natural alignment for kmalloc(power-of-two)").

> How about using get_free_pages() to implement this?

This would certainly work, at the expense of a lot of wasted memory when
PAGE_SIZE isn't 4k.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
