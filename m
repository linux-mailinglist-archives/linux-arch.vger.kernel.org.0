Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CC221928
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 02:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGPA6A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 20:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPA6A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 20:58:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D03C061755
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 17:57:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so5061233wrn.3
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 17:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=8t7YbdL4p7H/NHbPbXemPXmpbmcct4N4l3AbjbVoPJI=;
        b=FvGyXOquQxyBllbnVnMrqu56DGo7jKIGoAFYJhNgt3DFk0WkK2alTCyAcjS3Y59Iph
         DiyU6QZ52D4TiBE/VdpGFmOxusJiBC4l7xN2oW4NS6Y9LG7H4+Pfpu8oaB0+0BIb04+E
         z5JBEWjYcxsUetVd/QcagkLVnRKyp/lSoze0AuR6RMOPEmDJjFWpjMuHNQWEk+bp6f9c
         rRy0bMIKM/MXLO2f4fq5XYEwMJFccnWbCwPbOHzqijWq5VVFqhJAkgb2b6co+gRYFn0m
         TL+J90QticE8tR/zlSR+P0sooTb2+g4aQ+zvjlxD2vRqTmfCNv8r5qBzW1XBQerX+6+h
         tg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=8t7YbdL4p7H/NHbPbXemPXmpbmcct4N4l3AbjbVoPJI=;
        b=o3Ovn9LFh0LsU+oP4u3BQzHr1xkDlf9jJD8PiiQ768fWv4k1vLDYAb6Wz5d63eombR
         Jle38CEjNobnr3L1VCR1GQDlNu4rC6ApU5j3Y61LS1uOuwD1mcP5nVAoW/+u/VL4ipqc
         qWHMjVaeuajoC4tcBLHCCvR6JE1MH9BCMGczqLoIdWAA1jGPYOUsuWONVMhsBZ95Zp0f
         ww6QfCX79Xip+nLa6pyVMm/YG3kok2eBJaEpKC45jkEhNBz65sC34IrCaQF7cZAdY/ls
         nmvMKWWQPI6nLeDuKVRh0yjVBzM4uu8aHpgK5dMxKH5vESdqustX/a1y4wn8ULcpHBOY
         jERw==
X-Gm-Message-State: AOAM533T4JHiABUkwlxHhaKlGL2VLOOiRvv3sDxMLvEL+U/rUPiFZVTa
        Ht1Lcqmoe79fEIH5TLattzQ=
X-Google-Smtp-Source: ABdhPJwEy/3pQsa1L3+D7ZvBB6nAYRwUGYIzdbuYLTH3zKC4IimNZtkCXjKrQG17cZzjo0Piw1y4YA==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr2308607wrq.357.1594861078004;
        Wed, 15 Jul 2020 17:57:58 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id j4sm6295369wrp.51.2020.07.15.17.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 17:57:57 -0700 (PDT)
Date:   Thu, 16 Jul 2020 10:57:50 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200715094829.252208-1-npiggin@gmail.com>
        <849841781.14062.1594816035327.JavaMail.zimbra@efficios.com>
In-Reply-To: <849841781.14062.1594816035327.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Message-Id: <1594860978.y7ksqnxc5n.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Mathieu Desnoyers's message of July 15, 2020 10:27 pm:
> ----- On Jul 15, 2020, at 5:48 AM, Nicholas Piggin npiggin@gmail.com wrot=
e:
> [...]
>> index 47bd4ea0837d..a4704f405e8d 100644
>> --- a/arch/powerpc/include/asm/exception-64s.h
>> +++ b/arch/powerpc/include/asm/exception-64s.h
>> @@ -68,6 +68,13 @@
>>  *
>>  * The nop instructions allow us to insert one or more instructions to f=
lush the
>>  * L1-D cache when returning to userspace or a guest.
>> + *
>> + * powerpc relies on return from interrupt/syscall being context synchr=
onising
>> + * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SY=
NC_CORE
>> + * without additional additional synchronisation instructions. soft-mas=
ked
>> + * interrupt replay does not include a context-synchronising rfid, but =
those
>> + * always return to kernel, the context sync is only required for IPIs =
which
>> + * return to user.
>>  */
>> #define RFI_FLUSH_SLOT							\
>> 	RFI_FLUSH_FIXUP_SECTION;					\
>=20
> I suspect the statement "the context sync is only required for IPIs which=
 return to
> user." is misleading.
>=20
> As I recall that we need more than just context sync after IPI. We need c=
ontext sync
> in return path of any trap/interrupt/system call which returns to user-sp=
ace, else
> we'd need to add the proper core serializing barriers in the scheduler, a=
s we had
> to do for lazy tlb on x86.
>=20
> Or am I missing something ?

Maybe ambiguous wording. For IPIs, the context synch is only required=20
for those which return to user. Other things also require context sync.

I will try to improve it.

Thanks,
Nick
