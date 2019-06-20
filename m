Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18A84CA10
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2019 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfFTIzy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jun 2019 04:55:54 -0400
Received: from foss.arm.com ([217.140.110.172]:54528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfFTIzy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jun 2019 04:55:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE31D344;
        Thu, 20 Jun 2019 01:55:53 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 670B43F246;
        Thu, 20 Jun 2019 01:55:51 -0700 (PDT)
Subject: Re: [PATCH v6 00/19] Unify vDSOs across more architectures
To:     Shijith Thotton <sthotton@marvell.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <7baf295a-0cc6-1a0a-7e4e-ed33598a2242@marvell.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <eccdb6ec-3703-a22d-e6c0-4be31304e385@arm.com>
Date:   Thu, 20 Jun 2019 09:55:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7baf295a-0cc6-1a0a-7e4e-ed33598a2242@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Shijith,

...

> Observed good improvement for some APIs with the patch.
> 

Looks good. Thanks for testing the set, I will add your tag to my patches.

> Tested-by: Shijith Thotton <sthotton@marvell.com>
> 
> Thanks,
> Shijith
> 

-- 
Regards,
Vincenzo
