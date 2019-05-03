Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41051284E
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2019 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfECG7T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 May 2019 02:59:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfECG7S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 May 2019 02:59:18 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKJ1fXYz9sPJ; Fri,  3 May 2019 16:59:15 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d7fbe2a0439ce6f20917a65990a78c9e747aad34
X-Patchwork-Hint: ignore
In-Reply-To: <5ad9ed13155f55e1715274561354aa7ab57973fc.1554195798.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, danielwa@cisco.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] powerpc/prom_init: get rid of PROM_SCRATCH_SIZE
Message-Id: <44wNKJ1fXYz9sPJ@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:15 +1000 (AEST)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2019-04-02 at 09:08:38 UTC, Christophe Leroy wrote:
> PROM_SCRATCH_SIZE is same as sizeof(prom_scratch)
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d7fbe2a0439ce6f20917a65990a78c9e

cheers
