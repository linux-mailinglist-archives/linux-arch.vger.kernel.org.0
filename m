Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69FF3808F6
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhENLy4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 07:54:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:37389 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231839AbhENLy4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 07:54:56 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 14EBmDhI029374;
        Fri, 14 May 2021 06:48:14 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 14EBmDxj029373;
        Fri, 14 May 2021 06:48:13 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 14 May 2021 06:48:13 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 05/13] powerpc: use linux/unaligned/le_struct.h on LE power7
Message-ID: <20210514114813.GJ10366@gate.crashing.org>
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-6-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514100106.3404011-6-arnd@kernel.org>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Fri, May 14, 2021 at 12:00:53PM +0200, Arnd Bergmann wrote:
> Little-endian POWER7 kernels disable
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS because that is not supported on
> the hardware, but the kernel still uses direct load/store for explicti
> get_unaligned()/put_unaligned().
> 
> I assume this is a mistake that leads to power7 having to trap and fix
> up all these unaligned accesses at a noticeable performance cost.
> 
> The fix is completely trivial, just remove the file and use the
> generic version that gets it right.

LE p7 isn't supported (it requires special firmware), and no one uses it
anymore, also not for development.  It was used for powerpc64le-linux
development before p8 was widely available.


Segher
