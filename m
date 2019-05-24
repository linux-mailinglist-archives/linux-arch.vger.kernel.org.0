Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8161129D5E
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2019 19:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEXRm2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 May 2019 13:42:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfEXRm2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 13:42:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3EFF5308219F;
        Fri, 24 May 2019 17:42:28 +0000 (UTC)
Received: from treble (ovpn-121-106.rdu2.redhat.com [10.10.121.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 846315F7C5;
        Fri, 24 May 2019 17:42:26 +0000 (UTC)
Date:   Fri, 24 May 2019 12:42:24 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, will.deacon@arm.com, guillaume.gardet@arm.com,
        mark.rutland@arm.com, mingo@kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, x86@kernel.org
Subject: Re: [PATCH] x86/tools: deal with 64-bit relative relocations for
 per-CPU symbols
Message-ID: <20190524174224.pdj2hgyni675xaoi@treble>
References: <20190522174057.21770-1-ard.biesheuvel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522174057.21770-1-ard.biesheuvel@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 24 May 2019 17:42:28 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 22, 2019 at 06:40:57PM +0100, Ard Biesheuvel wrote:
> In order to fix an issue in the place relative ksymtab code, we
> need to switch to 64-bit place relative references, which
> require special handling in the x86 'relocs' tool. The reason
> is that per-CPU symbols on x86_64 live in a separate link time
> section, whose load time address is not reflected in the ELF
> metadata, and so relative references emitted by the toolchain
> are guaranteed to be wrong.
> 
> So fix this by extending the handling of 32-bit relative references
> to per-CPU variables to support 64-bit relative references as
> well.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> ---
> This is a follow-up to [0] and a prerequisite to the change it
> implements: using 64-bit relative references on x86_64 requires
> this handling in the 'relocs' tool and in the decompressor.
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20190522150239.19314-1-ard.biesheuvel@arm.com
> 
> This patch plus [0] build and boot tested with x86_64_defconfig on QEMU/kvm + OVMF.

NACK based on

https://lkml.kernel.org/r/f2141ee5-d07a-6dd9-47c6-97e8fbdccf34@arm.com

-- 
Josh
