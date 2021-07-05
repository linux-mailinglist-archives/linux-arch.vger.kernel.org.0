Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6A3BBB8A
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhGEKvW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jul 2021 06:51:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54528 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhGEKvW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jul 2021 06:51:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DBDD81FE56;
        Mon,  5 Jul 2021 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625482123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPw5944SyLvk8fb9DSeAYLp7rlJlKtCBdZpqaW/av88=;
        b=m3MKKUkS4eJfg01Dg3u0+FE7BI5AGUOW9VLhuf6+yhcvE6QF1UJ82MEqXIJt2UlTgl6+AR
        tnghOS98SWBr8e7maYhnnERk8vMYn/eraTtKSPpWtCj4v9dltSkFJSg/B6MsTTFUnPzERF
        Rlp4gVL9H7LnS5bpPhEl1S0hoEhLMaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625482123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPw5944SyLvk8fb9DSeAYLp7rlJlKtCBdZpqaW/av88=;
        b=v7HzFsoUGvAn2gSPetwqHR1/O5eJF5zi8P9YhBQo+Td7s6lpG9nqnynmgvCjlMGkwZUWoA
        Y7NVI0xqS+doxbBQ==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id 35F48A3B8F;
        Mon,  5 Jul 2021 10:48:43 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 08759446184; Mon,  5 Jul 2021 12:48:42 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-audit/audit-kernel 
        <reply+ADSN7RXLQ62LNLD2MK5HFHF65GIU3EVBNHHDPMBXHU@reply.github.com>,
        linux-audit/audit-kernel <audit-kernel@noreply.github.com>,
        Mention <mention@noreply.github.com>,
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
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
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
X-Yow:  I like the way ONLY their mouths move..  They look like DYING OYSTERS
Date:   Mon, 05 Jul 2021 12:48:42 +0200
In-Reply-To: <YN9V/qM0mxIYXt3h@yury-ThinkPad> (Yury Norov's message of "Fri, 2
        Jul 2021 11:07:58 -0700")
Message-ID: <mvm7di59gtx.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jul 02 2021, Yury Norov wrote:

> At least Marvell, Samsung, Huawei, Cisco and Weiyuchen's employer
> actively use and develop arm64/ilp32.

This is good to know.  Where can I get the uptodate kernel patches for
ILP32?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
