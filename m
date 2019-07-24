Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5CA7410A
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2019 23:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbfGXVtW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jul 2019 17:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387517AbfGXVtW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jul 2019 17:49:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FAAD308FBAF;
        Wed, 24 Jul 2019 21:49:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 241CA600D1;
        Wed, 24 Jul 2019 21:49:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1563993952.11067.15.camel@lca.pw>
References: <1563993952.11067.15.camel@lca.pw> <1563914986-26502-1-git-send-email-cai@lca.pw> <31573.1563954571@warthog.procyon.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        davem@davemloft.net, arnd@arndb.de, jakub@redhat.com,
        ndesaulniers@google.com, morbo@google.com, jyknight@google.com,
        natechancellor@gmail.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14025.1564004959.1@warthog.procyon.org.uk>
Date:   Wed, 24 Jul 2019 22:49:19 +0100
Message-ID: <14026.1564004959@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 24 Jul 2019 21:49:22 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Qian Cai <cai@lca.pw> wrote:

> I have GCC 8.2.1 which works fine.

But you need to check the minimum version, i.e. 4.6:

	#if GCC_VERSION < 40600

David
