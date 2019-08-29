Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9744EA1FA4
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 17:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfH2Ps7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 11:48:59 -0400
Received: from foss.arm.com ([217.140.110.172]:47270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfH2Ps7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:48:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78C1815AB;
        Thu, 29 Aug 2019 08:48:58 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2495F3F738;
        Thu, 29 Aug 2019 08:48:57 -0700 (PDT)
Subject: Re: [PATCH 2/7] lib: vdso: Build 32 bit specific functions in the
 right context
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
 <20190829111843.41003-3-vincenzo.frascino@arm.com>
 <CALCETrWNbMhYwpsKtutCTW4M7rMmOF0YUy-k1QgGEpY-Gd1xQw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <91cf55b4-63a1-9548-c7e0-c4dfa350b687@arm.com>
Date:   Thu, 29 Aug 2019 16:48:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWNbMhYwpsKtutCTW4M7rMmOF0YUy-k1QgGEpY-Gd1xQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 29/08/2019 16:23, Andy Lutomirski wrote:
> On Thu, Aug 29, 2019 at 4:19 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> clock_gettime32 and clock_getres_time32 should be compiled only with a
>> 32 bit vdso library.
>>
>> Exclude these symbols when BUILD_VDSO32 is not defined.
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> 
> BTW, this is a great patch: it's either correct or it won't build.  I
> like patches like that.
> 

Thanks :)

-- 
Regards,
Vincenzo
