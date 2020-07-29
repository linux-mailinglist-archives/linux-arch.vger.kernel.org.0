Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD7231F6F
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jul 2020 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2Nj7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jul 2020 09:39:59 -0400
Received: from foss.arm.com ([217.140.110.172]:51864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2Nj7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Jul 2020 09:39:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 694621FB;
        Wed, 29 Jul 2020 06:39:58 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59E5C3F66E;
        Wed, 29 Jul 2020 06:39:56 -0700 (PDT)
Subject: Re: [patch V5 00/15] entry, x86, kvm: Generic entry/exit
 functionality for host and guest
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200722215954.464281930@linutronix.de>
 <878sf8tz51.fsf@nanos.tec.linutronix.de>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e0edb228-b7e1-09ae-c41a-b5f4cbf37347@arm.com>
Date:   Wed, 29 Jul 2020 14:39:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878sf8tz51.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 24/07/2020 21:51, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> This is the 5th version of generic entry/exit functionality for host and
>> guest.
> 
> I've merged the pile in two steps. Patch 1-5, i.e. the generic code is
> here:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
> 
> and merged this branch and patch 6-15 into
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
> 
> core/entry is immutable and any updates, changes go on top. It's meant
> as a base for other architecture developers who want to fiddle with that
> without having to get the x86 mess as well.

Hi Thomas,

Just FYI: I'm going to take a look at arm64 support for this. I know 
Mark previously posted[1] a series moving much of the code to C, so 
hopefully I can build on that and make use of the generic code.

Thanks,

Steve

[1] https://lore.kernel.org/r/20200108185634.1163-1-mark.rutland@arm.com
