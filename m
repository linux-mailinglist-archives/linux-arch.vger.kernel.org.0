Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0511367FE
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 08:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgAJHLc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 02:11:32 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:13191 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgAJHLc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 02:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578640288;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=TC+tjX/Lt65GMWtVyL5Xhep5tinocrAB9X7xhvNdnXY=;
        b=AjSgPXDbCA/9jYWXNXFgLUjOFtmDTQOa7YI7vLzVZQdt9HmmRq+uzQx2rQqnt7jZCv
        VMSs79dsWoA8Rx1iIF/BTz/e1XbqClVxJ0ZCGNITdBh141AeNeap/+XnYku0f6WdgZQI
        l0zKfcjFyLwPmdpVMWKkNWGARGXKT3pk5SlWGe2Ypg5/Af1qrAYkmYt4616dwAibubso
        NuXucFAgEBAgUgCFKyMNPO7HMFBUd1DHWWEBSDOk54yNKWAyEqu+JXuMOjwIcAGiFxXB
        xuerO7B8he/Mjz9Om9MHJQSynx1SO2Eg5ND2FamP1E7/5/f2+yX5lSAFGWoQrczjy618
        nPPA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWd5jbpkxCcXi3g8qXe4kYOYilnn348Kw8dzMjA="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:8086:10a9:904f:8bb2:ac2:590a]
        by smtp.strato.de (RZmta 46.1.4 AUTH)
        with ESMTPSA id c05c1aw0A7AT8Ab
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 10 Jan 2020 08:10:29 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board installed, unless RAM size limited to 3500M
Date:   Fri, 10 Jan 2020 08:10:28 +0100
Message-Id: <533E86ED-00F4-4FB2-9D91-D4705088817D@xenosoft.de>
References: <20191204085634.GA25929@lst.de>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arch@vger.kernel.org, darren@stevens-zone.net,
        mad skateman <madskateman@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        paulus@samba.org, rtd2@xtra.co.nz,
        "contact@a-eon.com" <contact@a-eon.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de
In-Reply-To: <20191204085634.GA25929@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: iPhone Mail (17B111)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All,

The SCSI cards work again. [1, 2]

Sorry for bothering you.

Thanks,
Christian

[1] http://forum.hyperion-entertainment.com/viewtopic.php?f=3D58&p=3D49603&s=
id=3D1adf9e6d558c136c1ad4ff15c44212ba#p49599
[2] https://bugzilla.kernel.org/show_bug.cgi?id=3D205201=
