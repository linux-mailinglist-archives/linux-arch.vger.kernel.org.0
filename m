Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCD6116B0A
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2019 11:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfLIKbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 05:31:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfLIKbR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Dec 2019 05:31:17 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB62207FD;
        Mon,  9 Dec 2019 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575887476;
        bh=gafekmb4KwDK0GFglr1pIqczrJdYTdFqnQ7Hxp+1pNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y7CL2LY2P0Wt4SWbIonQ4EPnbdkoSkwr6PVzFh7izIJbM3ClApk9TBkeWb1EuINKC
         XYINiL8nP5MJkyBbbtJIp3hfFwqLDd+ygIMRa1+j2IRSJ0X/sWm19KFUZMBRmZKnyT
         B2MT2ZBN/nHWBQJqibdl+yX6hEB2qFeb9A+J7xnM=
Date:   Mon, 9 Dec 2019 10:31:11 +0000
From:   Will Deacon <will@kernel.org>
To:     Thomas Renninger <trenn@suse.de>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        fschnitzlein@suse.de, Felix Schnizlein <fschnizlein@suse.com>
Subject: Re: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Message-ID: <20191209103110.GB3306@willie-the-truck>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-4-trenn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206162421.15050-4-trenn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 06, 2019 at 05:24:21PM +0100, Thomas Renninger wrote:
> From: Felix Schnizlein <fschnizlein@suse.de>
> 
> Export all information from /proc/cpuinfo to sysfs:
> implementer, architecture, variant, part, revision,
> bogomips and flags are exported.
> 
> Example:
> /sys/devices/system/cpu/cpu1/info/:[0]# head *
> ==> architecture <==
> 8
> 
> ==> bogomips <==
> 40.00
> 
> ==> flags <==
> fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm
> 
> ==> implementer <==
> 0x51
> 
> ==> part <==
> 0xc00
> 
> ==> revision <==
> 1
> 
> ==> variant <==
> 0x0
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Felix Schnizlein <fschnizlein@suse.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 22 +++++++++
>  arch/arm64/Kconfig                                 |  1 +
>  arch/arm64/kernel/cpuinfo.c                        | 55 ++++++++++++++++++++++
>  3 files changed, 78 insertions(+)

I don't understand why we need this on arm64 and why it's an improvement
over all the other schemes we already support for identifying CPU features.

Given the pain we've endured over the years exposing this sort of stuff to
userspace, I'm relucant to add more just for the fun of it.

Will
