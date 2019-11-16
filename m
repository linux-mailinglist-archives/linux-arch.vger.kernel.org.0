Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB8FEB11
	for <lists+linux-arch@lfdr.de>; Sat, 16 Nov 2019 08:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfKPHGv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Nov 2019 02:06:51 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:27842 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfKPHGv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Nov 2019 02:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573888007;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:Cc:Message-Id:Subject:Date:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=zuFc8xULBzIlsh03+xVDOKfPqAywShuzPS+aigybEXY=;
        b=UB4i/dv1Fh++rrrsvW6krsp8k8+1MnAketf1Qnb5oVDyGsgQEt2BwLn1CJWErssOMB
        QfyDwtLjCHQFLykjSrcgUezqoZMKgTfjpT4nU46cM2gigPto4FrTHs64EvAwwwn/tf4p
        XHXcwH5t8S4m0tahYd4jEyA3sWkDNod9Fg88dcdV2AC6qRYNN4/YpIevzOzQrTAVKHlt
        SHOK9vugxrXLnmnamG5ajImTjfKPsVhorp4bUZq8QsZna38DfcTSKA7z+R0wQhc3cDin
        uOzpx4WzAYR7g+ohmH4BEOCSiG6wUN0sMjzoKat0FkUAAHMSgJIjEK8QapgS0sY4NphL
        zLcQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWZ537pkxH6J+aB1+9x3aDxi+HSYc7KsUHFpLrY="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:818d:108:b105:ba81:413a:5ece]
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id q007c8vAG7667Rt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 16 Nov 2019 08:06:06 +0100 (CET)
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Sat, 16 Nov 2019 08:06:05 +0100
Subject: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board installed, unless RAM size limited to 3500M
Message-Id: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, darren@stevens-zone.net,
        "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz,
        mad skateman <madskateman@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: iPhone Mail (16G102)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

FYI: Source files of the Dawicontrol DC 2976 UW SCSI board (PCI): https://gi=
t.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/s=
ym53c8xx_2?h=3Dv5.4-rc7

/*
 *  DMA addressing mode.
 *
 *  0 : 32 bit addressing for all chips.
 *  1 : 40 bit addressing when supported by chip.
 *  2 : 64 bit addressing when supported by chip,
 *      limited to 16 segments of 4 GB -> 64 GB max.
 */
#define   SYM_CONF_DMA_ADDRESSING_MODE CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_=
MODE

Cyrus config:

CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1

I will configure =E2=80=9C0 : 32 bit addressing for all chips=E2=80=9D for t=
he RC8. Maybe this is the solution.

> On 13. Nov 2019, at 12:02, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Interesting.  Give me some time to come up with a real fix, as drivers
> really should not mess with GFP flags for these allocations, and even
> if they did swiotlb is supposed to take care of any resulting problems.
