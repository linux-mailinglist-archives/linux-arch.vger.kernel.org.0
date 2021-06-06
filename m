Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B068B39D02E
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFFRYP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 13:24:15 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:26051 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFFRYP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 13:24:15 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 156HMMSa051939
        for <linux-arch@vger.kernel.org>; Sun, 6 Jun 2021 20:22:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623000137; x=1625592137;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ofh6S0qmxbTfwOwm6I6W/gPma32NXMANo65YCZP3Xvs=;
        b=G6lDnSKK77R8A849bGJ25Ey3IPPHNmHKtsEWtiaT8ySLxRN1CgvFHRTz3lYdC3Gb
        IiUd44ADfAmdZtwdIR/GQxZ/yhcvSk+iKUGJ7vN+78H0Jjk59TGxUhHz3Gr7GtKJ
        WUoYzchYtTmjMKbw7L1+8yV+8xY8w1PkTJZY5zw+YbOJ6l8NuhGpEZLG0K+MA3GZ
        96HXduLc+YlJYcyteF3C+2OJrOQbm8tGuIkVjkC6qGi215LnUjSTHui4T6fo57gD
        iChGdQ736ul6Ki8jT30a3Jj6+zmr+zfKwWi8w7EfEtkXkDDzM7nl8oRQY24yzqaf
        XFeSvKRKTknxtcvsHy930A==;
X-AuditID: 8b5b014d-96ef2700000067b6-e0-60bd04486a19
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 4A.2A.26550.8440DB06; Sun,  6 Jun 2021 20:22:16 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 06 Jun 2021 20:22:14 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, palmerdabbelt@google.com, arnd@arndb.de,
        wens@csie.org, maxime@cerno.tech, drew@beagleboard.org,
        liush@allwinnertech.com, lazyparser@gmail.com, wefu@redhat.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH v2 06/11] riscv: pgtable: Add DMA_COHERENT with custom
 PTE attributes
Organization: FORTH
In-Reply-To: <1622970249-50770-10-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-10-git-send-email-guoren@kernel.org>
Message-ID: <610849b6f66e8d5a9653c9f62f46c48d@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsXSHT1dWdeDZW+CwaPjlhZPPkxks/g76Ri7
        xb0Vy9gtXuxtZLE4/mgXi8XK1UeZLC59ucZi0bHrK4vF5V1z2Cy2fW5hs5iybxebxcp1x5gt
        Zvz4x2ixdeM6RouW/VNYLH4eOs/kIODxqu0Zk8fvX5MYPd79XsbocefceTaPDY9Ws3rsnHWX
        3WPBplKPTas62Tx2PrT02Lyk3uPF5pmMHrtvNrB5vN93lc3j8yY5j/YD3UwB/FFcNimpOZll
        qUX6dglcGfum72YvaOCoOHDmEnMD4062LkZODgkBE4ll0y4C2VwcQgLHGCU6fn+GSphKzN7b
        yQhi8woISpyc+YQFxGYWsJCYemU/I4QtL9G8dTYziM0ioCrxvasZrIZNQFNi/qWDYLaIgKjE
        +tnzwRYwCyxilth4eytYg7BAvMT2yc/YQWx+AWGJT3cvsnYxcnBwCjhL3N4FFhYSqJJYvvU6
        K8QNLhLXd6xhhbhNReLD7wfsIOWiQPbmuUoTGAVnIbl0FpJLZyG5dAEj8ypGgcQyY73M5GK9
        tPyikgy99KJNjOBIZfTdwXh781u9Q4xMHIyHGCU4mJVEeL1k9iQI8aYkVlalFuXHF5XmpBYf
        YpTmYFES5+XVmxAvJJCeWJKanZpakFoEk2Xi4JRqYJqUqDJJ9reE+6uaOWYlzSFl7abzt07o
        eluzd6NShuHpSS7vZfga6pniXtRdmlgW9XzGKZfsNedmN2Qw/9xV9UUrPaCL67Cw+GQLA2Oh
        V4K9HDc2bDjW9v9FMoPBOa0gW6muVtffxmb3JP7U9saGPjX99P7PoVuJN/qX3SsrXSLUEC1p
        n8d+4NFsRV8ZcyXZjqVRLWmhy35F31F6k2VmFcy0uy98+rJlwh8fce9MmT23duGWC5kX/N+H
        cfYzBm/e8e7q6sOtZkW3wq2a0jm8T7ybs6zgp5LZtLM/xYTXSEuK3tFcVKG01OnQcY+vD1be
        0/wb1lG/t9mfVcUk81yP9cTmWyJ2x+Q+ZDxkzszfosRSnJFoqMVcVJwIAKcjnVpDAwAA
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Στις 2021-06-06 12:04, guoren@kernel.org έγραψε:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The dma-noncoherent SOCs need different virtual memory mappings
> with different attributes:
>  - noncached + Strong Order (for IO/DMA descriptor)
>  - noncached + Weak Order (for writecombine usage, eg: frame
>    buffer)
> 
> All above base on PTE attributes by MMU hardware. That means
> address attributes are determined by PTE entry, not PMA. RISC-V
> soc vendors have defined their own custom PTE attributes for
> dma-noncoherency.
> 

This patch violates the Privilege Spec section 4.4.1 that clearly 
states:

"Bits63–54 are reserved for future standard use and must be zeroed by 
software for forward compatibility"

Standard use means that valid values can only be defined by the Priv. 
Spec, not by the vendor (otherwise they'd be marked as "custom use" or 
"platform use"), and since they "must" be zeroed by software we 'll be 
violating the Privilege Spec if we do otherwise.
