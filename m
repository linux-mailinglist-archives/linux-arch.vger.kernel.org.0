Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694C125E164
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 20:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIDSP0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 14:15:26 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgIDSPX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 14:15:23 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N1u2b-1kh6sy2GqX-012Dvb; Fri, 04 Sep 2020 20:15:21 +0200
Received: by mail-qt1-f172.google.com with SMTP id k25so4384913qtu.4;
        Fri, 04 Sep 2020 11:15:21 -0700 (PDT)
X-Gm-Message-State: AOAM533e69PysRwNoKpPesgSkinefoz9n3rM/xIVEpGTSJAT64OsF2S0
        K/u0S7RRl+OLPlFboo7vrGI+iC9IpJQcXO4u0e4=
X-Google-Smtp-Source: ABdhPJwucPkGj3LAptlXE2DwEcjRJWWLLErfX9qgvukoJGkc4WlGdVJ6sLBUa+bp1zSZuzZUqHdfNwF7k0QysP9l5QE=
X-Received: by 2002:ac8:46d7:: with SMTP id h23mr9627667qto.18.1599243320351;
 Fri, 04 Sep 2020 11:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200904165216.1799796-1-hch@lst.de>
In-Reply-To: <20200904165216.1799796-1-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 4 Sep 2020 20:15:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3t8a0gD2HsoPsMi7whtNb7BdzPN6-oo6ABnqkbQJoBfA@mail.gmail.com>
Message-ID: <CAK8P3a3t8a0gD2HsoPsMi7whtNb7BdzPN6-oo6ABnqkbQJoBfA@mail.gmail.com>
Subject: Re: remove set_fs for riscv
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:81BS4z0m57ZK4qyXrsq11zca2uneqsVnUM8XPOg7CT/FWoIaiS9
 fs3e+oG5cA56KISzqigr5geh6fO7HMpvO5Krv0Jst+QaBrIeQkTWarWjZivohl0DQqXq1AA
 KLYfcvm9U3jBcLldCoszKm0Yc97KTq2JY1UhVAQs8LsehhYxsCH7GkeF73SJ22gu1vroU+J
 1JkjvZWhMKYrW/9CtCldg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lr5TuermnBk=:PCoJktSSLG+ZeHvNw7N0zX
 cW6UggLRZYxqN/S9iWUgcEqRzrxOII8rOO4ZA/q/+gWQU9G9i2jr2Yfok6/qKIYr+PcgqcxC3
 JJ4k8qNQRYaYHcs0lLyVoJnEmqvdYjpf5evsuhTQMP1I1NcfUW0IK4WSTTV6kIRkkr/nH76MZ
 We/cWCyslsmg8ejLl9e5x48yuAdtOgi3/MehtVRib7Gz8mYBglz0NbSccdIz8O2gRJoXVgJ+H
 cJwlr458ljEA3E148exOzK4mV5IGYjnXg8z3nSaXmCwj/s2uXvM0S6MSHnq8du5Q5XUSyVR1T
 gTGTmTi12TPomz/w7efjmQ2hhd36lByAmfj2nUSKGBz+UcdYfScAxKr4ClJGZPo35xVkCnbH6
 4tzxwiH5vvjP5WWnuqY5uTp+4TN26is5jo2vV8NEzHVvktuyeDXkqFEwQPEP6N/c/wp7fQLGA
 i/qVbTFFGgElY4viid//pXk4GeQG/lbe+gVLUUTy5mvXENCW/9BHeSyfQA6NxdISEZoCEMdwk
 aLUaoWvnuncAK0769U5hROtNOPHWjWMRG+cVTVqPvJeszKzYowCqfirorSR166aGioERp05ER
 L+lcwZb9TPPvaCFm8avV0n7ynuqxFOHjsGSDVx3AOLA/N/fw6s4jXTFz4Wked3yUZJOCXlQM4
 p7C7kDid0B2LM6Bqh8tahIWJoas7B6cJg5Pzj6E0ApP8qZhwHZ9t/uDHY2uKhXrBWUsZBO/am
 L0W4Xq1ObsZ98DPv614YsbrBSdRSrxRFa91rIOSP9dK954ln9RwxApbBB8vIwc2GttYqffXJb
 LphFMIMXAh00P6t65Oe02ZjWE3AyF9aNeuZ7WDmTM9J8WAbQuyKwZenILYI2ASi7VzCQDDt4C
 OwgfpFtkQW/EDJ7NP8JvU0+TxPg1qbwamQvM/ScaARqe3fN/xyKLnIla7tpv68AyW/5a3FCsE
 I5j9wYpnRJ5lxRBgYGNbLq3wS/FWoM5NykKCKWYcq0A6HnSLMCIy2
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 4, 2020 at 6:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> this series converts riscv to the new set_fs less world and is on top of this
> branch:
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=base.set_fs
>
> The first four patches are general improvements and enablement for all nommu
> ports, and might make sense to merge through the above base branch.

For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>

Is there a bigger plan for the rest? I can probably have a look at the Arm
OABI code if nobody else working on that yet.

      Arnd
