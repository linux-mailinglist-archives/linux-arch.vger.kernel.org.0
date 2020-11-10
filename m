Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04732AD2E0
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 10:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKJJx4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 04:53:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgKJJx4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 04:53:56 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B09F20780;
        Tue, 10 Nov 2020 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605002035;
        bh=p0jnGkb4pdN3N6lz9q+O5UWX5vyGxnkD1ZvR1w/KJ54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yp6fPt02nKPTeSDTkjYbMFakobpp8vbvRIYgeuZcBclQj/r/Sjax7qTeKf5biVv74
         DbEV/gYn18PSsKPDJAYdPW+0CETTbqXPCO9IF75trLK97Sge0xIz5Ewm8hTTOTW89x
         tKAi8nP+ZIYd7RgG/pBBduFym8V163YvLUuF8n3w=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcQLZ-009PET-Ai; Tue, 10 Nov 2020 09:53:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 09:53:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 5/6] arm64: Advertise CPUs capable of running 32-bit
 applications in sysfs
In-Reply-To: <X6pfISu1PE5lelNL@kroah.com>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-6-will@kernel.org> <X6o7euVw0QlysIPV@kroah.com>
 <X6pdSx84CWvag02r@trantor> <X6pfISu1PE5lelNL@kroah.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <e09e755dd5058103241c1c919d6af076@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, peterz@infradead.org, morten.rasmussen@arm.com, qais.yousef@arm.com, surenb@google.com, qperret@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-11-10 09:36, Greg Kroah-Hartman wrote:

[...]

> While punting the logic out to userspace is simple for the kernel, and
> of course my first option, I think this isn't going to work in the
> long-run and the kernel will have to "know" what type of process it is
> scheduling in order to correctly deal with this nightmare as userspace
> can't do that well, if at all.

For that to happen, we must first decide which part of the userspace
ABI we are prepared to compromise on. The most obvious one would be to
allow overriding the affinity on exec, but I'm pretty sure it has bad
interactions with cgroups, on top of violating the existing ABI which
mandates that the affinity is inherited across exec.

There may be other options (always make at least one 32bit-capable CPU
part of the process affinity?), but they all imply some form of 
userspace
visible regressions.

Pick your poison... :-/

         M.
-- 
Jazz is not dead. It just smells funny...
