Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0F83BA3E5
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhGBSWg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 14:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhGBSWg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 14:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625250003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ljBkCCbVc5OdHhjmFR2eMLVXMDCuwitek0RrMPP1ROw=;
        b=UqV4iIq9o44npzb2Lh0WO+KLkSmp6I9kPjU7T/daO/Gx50NXKo2p+KTDp8BJ+jSPGH+4T4
        rCRqNLe+OrtR+YulJQn8Krd05tvSZLAjMjYJSNA2IziiU7h8Y6YDgVQN07D4/FwJ9A665s
        RAQp660TmD8D/gdr8SkdmhHmB02zY24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-vXm2Qzy_NPCQampVscaRcA-1; Fri, 02 Jul 2021 14:20:01 -0400
X-MC-Unique: vXm2Qzy_NPCQampVscaRcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FF17C7403;
        Fri,  2 Jul 2021 18:19:56 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6FD060853;
        Fri,  2 Jul 2021 18:19:47 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-audit/audit-kernel 
        <reply+ADSN7RXLQ62LNLD2MK5HFHF65GIU3EVBNHHDPMBXHU@reply.github.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        bobo.shaobowang@huawei.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [linux-audit/audit-kernel] BUG: audit_classify_syscall() fails
 to properly handle 64-bit syscalls when executing as 32-bit application on
 ARM (#131)
References: <linux-audit/audit-kernel/issues/131@github.com>
        <linux-audit/audit-kernel/issues/131/872191450@github.com>
        <YN9V/qM0mxIYXt3h@yury-ThinkPad>
Date:   Fri, 02 Jul 2021 20:19:46 +0200
In-Reply-To: <YN9V/qM0mxIYXt3h@yury-ThinkPad> (Yury Norov's message of "Fri, 2
        Jul 2021 11:07:58 -0700")
Message-ID: <87zgv4y3wd.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Yury Norov:

> At least Marvell, Samsung, Huawei, Cisco and Weiyuchen's employer
> actively use and develop arm64/ilp32. I receive feedback / bugrepotrs
> on ilp32 every 4-6 month. Is that enough for you to reconsider
> including the project into the mainline?

I believe that glibc has the infrastructure now to integrate an ILP32
port fairly cleanly, although given that it would be first
post-libpthread work, it would have to absorb some of the cleanup work
for such a configuration.

(I do not plan to work on this myself.)

Thanks,
Florian

