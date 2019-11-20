Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2B103CFF
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2019 15:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfKTOKB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Nov 2019 09:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfKTOKB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Nov 2019 09:10:01 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54D92230F;
        Wed, 20 Nov 2019 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574259000;
        bh=WFdws+SnK1zQYzyDACA7oOkYtJ9MqizxzDeS+6lUkxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UxzSKJfOr7rSNFaJ23Xs168qJgB2iTpMNCdi5Pv9DZ6KYltlVlg/H0aqDr1qlk8do
         9M/3PmakQkyrfhyX0Jd1SBMpm+dZgJHqJHJT1MfoSNlEJal1GucKqUB5/pA3rFrfr6
         4UF3lAwHg45ENATmDt3MpR3lypBes+i8oVZkCPe4=
Date:   Wed, 20 Nov 2019 09:09:59 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, david@redhat.com, arnd@arndb.de,
        bp@alien8.de, daniel.lezcano@linaro.org, hpa@zytor.com,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
        Alexander.Levin@microsoft.com, vkuznets@redhat.com,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Implement hv_is_hibernation_supported() and
 enhance hv_balloon for hibernation
Message-ID: <20191120140959.GG16867@sasha-vm>
References: <1574234165-49066-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1574234165-49066-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 19, 2019 at 11:16:03PM -0800, Dexuan Cui wrote:
>v2 is actually the same as v1. This is just a resend.
>
>I suggest both the patches should go through the Hyper-V tree:
>https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
>because the first patch is needed by the second one.
>
>This first patch doesn't conflict with any patch in the tip.git tree.

Queued for hyperv-next, thanks!

-- 
Thanks,
Sasha
