Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736FB35C6A9
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 14:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbhDLMsJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 08:48:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38870 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbhDLMsJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 08:48:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618231670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XDUgZVHsV7/vHCbmfDZhFYUbv1Qm8FRk0fOlAV4IBn0=;
        b=ctnylBHFtV4GSt7oxiFjMPSTheoqRRPDVjTVvDiKGe7EYKwowFtZXntvohPz09OyXmo6Ge
        Tlh5OIYTmAN2Mp3aShUrlGOVcSEVdYopsWflLA15/mCCPF6qjaLD0ERd/ogiqBtc7zRCQp
        ucSKvEUYbb2RzWENP+EOLUDWbTLz7mUFJjYEA2wNAq0aURiejvFcmySEoxg/RU8imxLFYX
        4ZBHSBvUobC2Nfzo+h3/BTwtMvgMbT8nZv8PjRB7T/TS0eW7dB/aPwLxUhDk1JGop/RjYM
        UXAPZR63YLOIAj+NOISgSQwdo66GiNIHAPSWlXw+CJtkdyjK6dab4/xRfPPpmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618231670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XDUgZVHsV7/vHCbmfDZhFYUbv1Qm8FRk0fOlAV4IBn0=;
        b=rCz08sj8BXMgUVLsgDotEOxcVLgGrnuIVx/2ybSd/XFsXsmTp2mLdwFk0arl2G6Jr/08vS
        aCPvCbZrIZh0C/Dg==
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, avagin@gmail.com, arnd@arndb.de,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND v1 1/4] lib/vdso: Mark do_hres_timens() and do_coarse_timens() __always_inline()
In-Reply-To: <90dcf45ebadfd5a07f24241551c62f619d1cb930.1617209142.git.christophe.leroy@csgroup.eu>
References: <cover.1617209141.git.christophe.leroy@csgroup.eu> <90dcf45ebadfd5a07f24241551c62f619d1cb930.1617209142.git.christophe.leroy@csgroup.eu>
Date:   Mon, 12 Apr 2021 14:47:49 +0200
Message-ID: <87r1jf1xfu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31 2021 at 16:48, Christophe Leroy wrote:
> In the same spirit as commit c966533f8c6c ("lib/vdso: Mark do_hres()
> and do_coarse() as __always_inline"), mark do_hres_timens() and
> do_coarse_timens() __always_inline.
>
> The measurement below in on a non timens process, ie on the fastest path.
>
> On powerpc32, without the patch:
>
> clock-gettime-monotonic-raw:    vdso: 1155 nsec/call
> clock-gettime-monotonic-coarse:    vdso: 813 nsec/call
> clock-gettime-monotonic:    vdso: 1076 nsec/call
>
> With the patch:
>
> clock-gettime-monotonic-raw:    vdso: 1100 nsec/call
> clock-gettime-monotonic-coarse:    vdso: 667 nsec/call
> clock-gettime-monotonic:    vdso: 1025 nsec/call
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
