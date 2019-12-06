Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307BE115591
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLFQhY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 11:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfLFQhY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Dec 2019 11:37:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F282173E;
        Fri,  6 Dec 2019 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575650243;
        bh=yWXoL/mvYsdoAyZ4GxWSyH4/qqGbZpN5M3vSC32W8z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giaVFVwPk8xbp68N1BV+SN7k3CdeIblM6jnoapwjNILrTIpk211MmDZh3+fMJPOKj
         DLcZdrnmQqKkleHjhVwXZ/m9dh6I+mVjN0pabmelsfzaCgE9bURHy9IB2cMP7RT59W
         VfTn6ekPBwyXyKyxk3jBWIIgu0mvFpWXfLjV9uKg=
Date:   Fri, 6 Dec 2019 17:37:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Renninger <trenn@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        fschnitzlein@suse.de, Felix Schnizlein <fschnizlein@suse.com>
Subject: Re: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Message-ID: <20191206163720.GD86904@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-4-trenn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206162421.15050-4-trenn@suse.de>
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

Same comments as on the x86 patch :(
