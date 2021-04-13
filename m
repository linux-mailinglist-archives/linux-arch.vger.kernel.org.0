Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9049035D817
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 08:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhDMGcE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 02:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhDMGcA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 02:32:00 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69149C061574;
        Mon, 12 Apr 2021 23:31:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FKG3970gmz9sVb;
        Tue, 13 Apr 2021 16:31:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1618295497;
        bh=tMH4STlE0KCPkig0ixz3tk4Pi9eX9DRFBNDHWYY01Ts=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o2/PtY2poIFEx77VRY0BfPEzN/kb88EHi7/vCJWpPx+lINy6RBoE2ODKSw8EAuoS0
         pqMFuC4cNfJ1iKEu61nuc50SL+B2Vf3oH/z+eufKAVYJLlj9ryfjyDNy02Rz2u2qJM
         yv+EoMmVWFFCbKMeNmTast89xuFs+sBbNFOe4myjLJ+02Ej+NMfYfy/1QeRdJaV/vV
         y4+hQOjO7Kw4uW47mSQQMfxcibmWTRihbkri1Hp8VJvrarJ2rYsWSm3eHbOs86hgWC
         VTaicS0GIPCdSyviECNSmn6tTP6yVjhLG3IXo0yAw9hQMp5PfVEiRpq5vz4VQhsvoY
         1abQoEgmQRejg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, avagin@gmail.com, arnd@arndb.de,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND v1 0/4] powerpc/vdso: Add support for time
 namespaces
In-Reply-To: <87mtu31xd3.ffs@nanos.tec.linutronix.de>
References: <cover.1617209141.git.christophe.leroy@csgroup.eu>
 <87mtu31xd3.ffs@nanos.tec.linutronix.de>
Date:   Tue, 13 Apr 2021 16:31:33 +1000
Message-ID: <87tuoag0fu.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> On Wed, Mar 31 2021 at 16:48, Christophe Leroy wrote:
>> [Sorry, resending with complete destination list, I used the wrong script on the first delivery]
>>
>> This series adds support for time namespaces on powerpc.
>>
>> All timens selftests are successfull.
>
> If PPC people want to pick up the whole lot, no objections from my side.

Thanks, will do.

cheers
