Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96A10596E
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2019 19:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKUSWA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Nov 2019 13:22:00 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:29129 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSWA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Nov 2019 13:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574360518;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=jNSqqBbrYyqRlctFmIILYVh2+dTk9ekgd8eo+LGizrs=;
        b=IoSWbE9aKV7MblpDIVy6d4DAwjkm6mUFCG4oqGRimcMxNJsCuU0cYxjpQN2Y7Efw6o
        uQSaW3AVvv14bWVFGvf2LTTK2IIOpoGP4k6rZBTXyxQ7RJP84hEzuKx0uWIvQq493219
        w/x3QDBmXU8XZQ+iDeCFMurV7Duta58Ci3eec2OORNswY81UQyo1ErwStCETmIAiO9/J
        nmJKrXoOzGomJXQo4WY4u8O+N6lvWrXaxsMb0g+v5+vHaWmNGvD9AwyyT88lH6aJSQ5m
        YeFIkWCeKuj8mZ3KtQQhjy7a2oRL4AQ56PgUYnWbSmZZEIg6LoPcJKOoE3OlnCTn8SVD
        vE8A==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4QgaM9fNtIXuaJFG8GgaIfjP/sNprV1dfhtth/q6Z5w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:31b4:3e86:1da2:8b32]
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id q007c8vALIL5lAy
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Nov 2019 19:21:05 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board installed, unless RAM size limited to 3500M
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <20191121180226.GA3852@lst.de>
Date:   Thu, 21 Nov 2019 19:21:04 +0100
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org,
        darren@stevens-zone.net, mad skateman <madskateman@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        paulus@samba.org, rtd2@xtra.co.nz,
        "contact@a-eon.com" <contact@a-eon.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F53CCCE-738C-4024-9C3C-4BDEB0D0728C@xenosoft.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de> <20191121072943.GA24024@lst.de> <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de> <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de> <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com> <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de> <20191121180226.GA3852@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21. Nov 2019, at 19:02, Christoph Hellwig <hch@lst.de> wrote:

On Thu, Nov 21, 2019 at 05:34:48PM +0100, Christian Zigotzky wrote:
I modified the patch and compiled a new RC8 of kernel 5.4 today. (patch=20
attached)

We have to wait to Rolands test results with his SCSI PCI card. I tested it=20=

today but my TV card doesn't work with this patch.

I think we have two sorta overlapping issues here.  One is that I think
we need the bus_dma_limit, which should mostly help for something like
a SCSI controller that doesn't need streaming mappings (btw, do we
have more details on that somewhere?).

And something weird with the videobuf things.  Your change of the dma
masks suggests that the driver doesn't do the right allocations and thus
hits bounce buffering (swiotlb).  We should fix that for real, but the
fact that the bounce buffering itself also fails is even more interesting.

Can you try this git branch:

   git://git.infradead.org/users/hch/misc.git fsl-dma-debugging

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/fsl-dma-d=
ebugging

and send me the dmesg with that with your TV adapter?

- - -

Yes, I will test it at the weekend. Thanks for your help.

Christian=
