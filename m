Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0316B1170FA
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2019 16:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfLIP6f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 10:58:35 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:53947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfLIP6f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 10:58:35 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MNLVU-1iOKkV20xW-00OnEP; Mon, 09 Dec 2019 16:58:33 +0100
Received: by mail-qv1-f46.google.com with SMTP id q19so2809690qvy.9;
        Mon, 09 Dec 2019 07:58:33 -0800 (PST)
X-Gm-Message-State: APjAAAUoU8BF8ueQj5y/rcHN0vuvRTcah7uj4o3ISVyuScVYjdaxse4B
        d9yL1JwXtd42IxgUdMzuHLajILp3ZQLrmIDAxK8=
X-Google-Smtp-Source: APXvYqzfA+s4iigShH1OUpALL9pM7Gi5eTR9vcm3mrcT15Eg4/g1ot1Er+BU82thfTbRYCX8LBbFI+f6z63dKsAgo00=
X-Received: by 2002:ad4:4021:: with SMTP id q1mr19050150qvp.211.1575907112236;
 Mon, 09 Dec 2019 07:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20191209135823.28465-1-hch@lst.de> <20191209135823.28465-3-hch@lst.de>
In-Reply-To: <20191209135823.28465-3-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Dec 2019 16:58:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0xD-kdKYzDp+hvN=uHwSJtzYE-YSyR3_mkxOTUEs-C3w@mail.gmail.com>
Message-ID: <CAK8P3a0xD-kdKYzDp+hvN=uHwSJtzYE-YSyR3_mkxOTUEs-C3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] remove ioremap_nocache and devm_ioremap_nocache
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9oSL+iTX1j7w13cDsj385o7u5nBN4GfwQ1WRH4zI6gesS0J8Cbb
 Rgr977O7tsEZTjTNTHkK8KypxssCzb2DSk39PAwgDTxfF8bhu1FDT7NWPLNWUnKr1u/g5Tr
 tciqyUWmL5W6F0F7ZkOo9U5L1cm4TYd7QvlhSG2SzakXGwJWGTli47oT5CtMPd1wwe5KMGn
 I2ZIHQrgZxmixxWj4eQCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ICMB7ZLL84U=:FuzPXns+7fRA/FGWvTn8u7
 8fpd1EWICrUsjMk/TeTeAyCqLSC8rK8zZpzjgXAf+1NWoR0l51c/UwrcLczXQHbyMdN3kO3Ng
 QVTB4pLzr19BuXrX/dK03W5L5xaJwZnDt8w8jyTIXDvWTSCtQktCNSSH9NshqjSmZuTasUZ6B
 PhIfa3Fq9d3hpaHeUMvcch/nWV3g+yemZYSHhYCR80ZEkxB3aUFN1vmDCSsPQ/caLodOttSZk
 zbeu9021Bx/nwew3sy5AHxjGOdJmMExTfMoVAUUTK6yoXftoJTPJEKAoQaYwaUhBUJUiCHGaj
 dPqiyZ1xjZzU6Yo8W/VTCfPDvocWJx9sG3purfVKHmZFrVUx0jpDvjOmGlETc2r2u1qfvlJCQ
 jgUO8gpJQXEXdPtEQNJrLUp7UcViLzNiceRrhqTYg22IZokGHd/lN+2h8mVPq5jBop/Im/uin
 rStShBnHmUMqXgU1rN1jseLKs2xLzTwyAhtOp9nxs6uUB5WheLfWAhfX9zyPg1f+q4OIelfcu
 rH+zUE3XVisx2aM/cq5ccnFw9C2C2DNBgfEHYQum51Y2PTYj8oiau/1LA13Abyqx0Mrm/Rt7Z
 t0abxaGIyC2h2JCBizE5WuyjO3Qlxy/LJ/5FudGdVOOs0e2EvKEGx/MTTGK2QyqPugSpvI+M3
 XCkrDa9n5icoMOw26gTpZVT1Wf2FCKq7lcBqbA/jSXiYmGmqzHb2kT5xUQnAvYg/KmRbINrf1
 khAzjiYdHrka/TsLLDoUN1yHMC7racxwF3GXXAbEmz/JlwNEMwga48Gtu1CdUnrk+teXQnymn
 p8VxDiJ6q4PtuJ8HK+jxAH0C96n57oJCKJDR9XnQmiiWBHRJBVcqbvF4TOm9YKrI74+7BnCFE
 PJLS1J/BUOG12HC/wUyg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 9, 2019 at 2:58 PM Christoph Hellwig <hch@lst.de> wrote:
>
> ioremap has provided non-cached semantics by default since the Linux 2.6
> days, so remove the additional ioremap_nocache interface.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Great work, thanks for getting this done!

Acked-by: Arnd Bergmann <arnd@arndb.de>
