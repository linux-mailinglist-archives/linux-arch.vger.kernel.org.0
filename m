Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E6635C6AF
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbhDLMs3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 08:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbhDLMs2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 08:48:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A43C061574;
        Mon, 12 Apr 2021 05:48:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618231686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=msG8qht51owt3dOAb8bO2Q/JGreHFsZAw+taKjc/k/0=;
        b=ttKtKfHTkJMwc/7gd8FTEtSE7z6D37j94Fd9vBOq7/5KqXfG2VdD2seAIKa2ZxaQ4sr7+l
        nGov0CrV1JbRb/6kaL2bDGO5CNfBL55UWrXwSPTp/4omJnPFHeNed6WfSyqWBQ3KmL3ynH
        newr6bQfGxD9dMNXt6q5i0rz6hRhJHgMjhz3FnJwvjooffnIE6uwtqgu01N6O1OqwKInHm
        zkc7OCVHrlvOtjOeaZrixX0yZlVwt194a6ixyUZ9nJP1DJjxf/uBUshsd+nV+d7HP3FQNj
        5oqdCabdmEpESdF41ciIKsY2CEGM6wPLhZWSPSB0fik0mvawW34S24fH2eHTaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618231686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=msG8qht51owt3dOAb8bO2Q/JGreHFsZAw+taKjc/k/0=;
        b=rsZEHxCyPYPtlclpxkmK9d9/VTx1jx273GBJjXOqpEEbmozWkgV2sLzK2xydvH3QpabVRr
        WclALlc+a7gZW9Ag==
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, avagin@gmail.com, arnd@arndb.de,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND v1 2/4] lib/vdso: Add vdso_data pointer as input to __arch_get_timens_vdso_data()
In-Reply-To: <539c4204b1baa77c55f758904a1ea239abbc7a5c.1617209142.git.christophe.leroy@csgroup.eu>
Date:   Mon, 12 Apr 2021 14:48:06 +0200
Message-ID: <87pmyz1xfd.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31 2021 at 16:48, Christophe Leroy wrote:
> For the same reason as commit e876f0b69dc9 ("lib/vdso: Allow
> architectures to provide the vdso data pointer"), powerpc wants to
> avoid calculation of relative position to code.
>
> As the timens_vdso_data is next page to vdso_data, provide
> vdso_data pointer to __arch_get_timens_vdso_data() in order
> to ease the calculation on powerpc in following patches.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
