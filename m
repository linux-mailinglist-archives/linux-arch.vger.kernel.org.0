Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F850F2652
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2019 05:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbfKGELT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 23:11:19 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37289 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfKGELT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 6 Nov 2019 23:11:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 477qhh1Mjhz9sSZ;
        Thu,  7 Nov 2019 15:11:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573099877;
        bh=jm+Vmz+Pe7sP6gnY/53imRBZ6Tetxa/ULKWT1LQn32s=;
        h=From:To:Cc:Subject:Date:From;
        b=nGEZ4HSTIgls3CXaH1R45tNp1G2bg8tkVvtlcpeSIfLUtD5OacZlsKhOdD1Ah17UQ
         bBsQAoFnSZvqLWXFbDk0cKgJp6EBi7eytHRbm7UfTei8PuVnMjKzaxB8TONbnIGNNN
         N7IGsFNfl6qqIdqPgZTtatB0zDhjUwfNQBNJssxVO4WBVRkC5898TJ4D1wpjiYLeYt
         7Dk3E5B0Jvp2CST7nOThi6BCxwPh0lkYLdyXT00PVJhXXbuOhrEjNEC6TKNkGKWYc+
         hgOba/wksd6OuWw0k5D/ajIoH6NTRdo4mle0T4b6fX3+R2n5EF4wuAo3xTalLBD3zK
         5f+x1pwWBpUww==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next@vger.kernel.org, christophe.leroy@c-s.fr,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, Daniel Axtens <dja@axtens.net>
Subject: Please add powerpc topic/kasan-bitops branch to linux-next
Date:   Thu, 07 Nov 2019 15:11:12 +1100
Message-ID: <87r22k5nrz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Stephen,

Can you please add the topic/kasan-bitops tree of the powerpc repository
to linux-next.

powerpc         git     git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git#topic/kasan-bitops

See:
  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/kasan-bitops

This will be a (hopefully) short lived branch to carry some cross
architecture KASAN related patches for v5.5.

cheers
