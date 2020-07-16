Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146C02222FD
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGPMzw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 08:55:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMzv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jul 2020 08:55:51 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPb6rTHz9sTC; Thu, 16 Jul 2020 22:55:47 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     nathanl@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincenzo.frascino@arm.com, tglx@linutronix.de, luto@kernel.org,
        arnd@arndb.de, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1588079622.git.christophe.leroy@c-s.fr>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
Subject: Re: [PATCH v8 0/8] powerpc: switch VDSO to C implementation
Message-Id: <159490400799.3805857.1673818426986159282.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:47 +1000 (AEST)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 28 Apr 2020 13:16:46 +0000 (UTC), Christophe Leroy wrote:
> This is the seventh version of a series to switch powerpc VDSO to
> generic C implementation.
> 
> Main changes since v7 are:
> - Added gettime64 on PPC32
> 
> This series applies on today's powerpc/merge branch.
> 
> [...]

Patch 1 applied to powerpc/next.

[1/8] powerpc/vdso64: Switch from __get_datapage() to get_datapage inline macro
      https://git.kernel.org/powerpc/c/793d74a8c78e05d6833bfcf582e24e40bd92518f

cheers
