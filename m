Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D237424CF
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 13:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjF2LKq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 07:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjF2LKb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 07:10:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FECD30C4;
        Thu, 29 Jun 2023 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1688037027;
        bh=sv/JdQWXY6nWSKNJyVKNtJGaF1eiIkhg3/IJgGGitu0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JHtvQCEEKCFpe536YpnBQY4lzDoxafqWNvDqcJZfV0kdQQ+u0REqsHyuSl1CKrUMy
         W1LoOm199ryLQ0WjvAzM2VoFXwq9YGq0j16IsN7QYgL3Kbykd67g/EJKefxd/pK8PS
         PDvxu1qWXbXujyjcooYA8QDRy884V0RZdUTySP7eyhyJ2A0FgBS5ybm/dM5YUb4Cax
         IEvSrElRkPOB9/F30mXrwhCk9syA1dwcFcFrkPXFENJM6XIXowYKFUpeU/Iu1XnF2N
         mnVtEWlhUV3H4MshIKtxy/qtt04eqaY56cyMhkiKF7Ta8Wcc26MS5NrmyeH/Vj3Y5K
         yfVEdWBMV+SuQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsG2V61t6z4wp1;
        Thu, 29 Jun 2023 21:10:26 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sachin Sant <sachinp@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch@vger.kernel.org, dave.hansen@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        npiggin@gmail.com, tglx@linutronix.de
Subject: Re: [PATCH v2 0/9]  Introduce SMT level and add PowerPC support
In-Reply-To: <88E208A6-F4E0-4DE9-8752-C9652B978BC6@linux.ibm.com>
References: <20230628100558.43482-1-ldufour@linux.ibm.com>
 <88E208A6-F4E0-4DE9-8752-C9652B978BC6@linux.ibm.com>
Date:   Thu, 29 Jun 2023 21:10:25 +1000
Message-ID: <87edluh6ce.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sachin Sant <sachinp@linux.ibm.com> writes:
>> On 28-Jun-2023, at 3:35 PM, Laurent Dufour <ldufour@linux.ibm.com> wrote:
>>=20
>> I'm taking over the series Michael sent previously [1] which is smartly
>> reviewing the initial series I sent [2].  This series is addressing the
>> comments sent by Thomas and me on the Michael's one.
>>=20
>> Here is a short introduction to the issue this series is addressing:
>>=20
>> When a new CPU is added, the kernel is activating all its threads. This
>> leads to weird, but functional, result when adding CPU on a SMT 4 system
>> for instance.
>>=20
>> Here the newly added CPU 1 has 8 threads while the other one has 4 threa=
ds
>> active (system has been booted with the 'smt-enabled=3D4' kernel option):
>>=20
>> ltcden3-lp12:~ # ppc64_cpu --info
>> Core   0:    0*    1*    2*    3*    4     5     6     7
>> Core   1:    8*    9*   10*   11*   12*   13*   14*   15*
>>=20
>> This mixed SMT level may confused end users and/or some applications.
>>=20
>
> Thanks for the patches Laurent.
>
> Is the SMT level retained even when dynamically changing SMT values?
> I am observing difference in behaviour with and without smt-enabled
> kernel command line option.
>
> When smt-enabled=3D option is specified SMT level is retained across=20
> cpu core remove and add.
>
> Without this option but changing SMT level during runtime using
> ppc64_cpu =E2=80=94smt=3D<level>, the SMT level is not retained after
> cpu core add.

That's because ppc64_cpu is not using the sysfs SMT control file, it's
just onlining/offlining threads manually.

If you run:
 $ ppc64_cpu --smt=3D4=20

And then also do:

 $ echo 4 > /sys/devices/system/cpu/smt/control

It should work as expected?

ppc64_cpu will need to be updated to do that automatically.

cheers
