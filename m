Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBE14D716
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2020 08:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgA3Hho (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jan 2020 02:37:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52480 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA3Hho (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jan 2020 02:37:44 -0500
Received: from [195.177.82.11] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ix4OO-0003G3-Fe; Thu, 30 Jan 2020 08:37:36 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 758E5105CFC; Thu, 30 Jan 2020 08:37:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     "arnd\@arndb.de" <arnd@arndb.de>, "bp\@alien8.de" <bp@alien8.de>,
        "daniel.lezcano\@linaro.org" <daniel.lezcano@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa\@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page for hibernation
In-Reply-To: <20200130000552.GD2896@sasha-vm>
Date:   Thu, 30 Jan 2020 08:37:29 +0100
Message-ID: <877e195r9i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:
> On Sat, Jan 25, 2020 at 01:44:31AM +0000, Dexuan Cui wrote:
>>> This is a RESEND of https://lkml.org/lkml/2019/11/20/68
>>>
>>> Please review.
>>>
>>> If it looks good, can you please pick it up through the tip.git tree?
>>>
>>>  arch/x86/hyperv/hv_init.c | 48
>>> +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 48 insertions(+)
>>
>>Hi, Vitaly and x86 maintainers,
>>Can you please take a look at this patch?
>
> Ping?
>
> This patch has been floating around in it's current form for the past 2
> months. I'll happily take Hyper-V patches under arch/x86/hyperv/ via the
> Hyper-V tree rather than tip if the x86 folks don't want to deal with
> them.

sorry fell through the cracks. Will take care of it.
