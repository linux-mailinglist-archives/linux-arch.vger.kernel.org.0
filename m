Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793ED66C224
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jan 2023 15:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjAPOYu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Jan 2023 09:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjAPOYU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jan 2023 09:24:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3642127488
        for <linux-arch@vger.kernel.org>; Mon, 16 Jan 2023 06:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673878102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iBR6LpmTfuNlZNPZuo1jcAuw8ZocBo9TD/tE524PhVg=;
        b=dceia3nCSmGpWMQuadipit6Vkv+tzvP3B1hAh7F/NRFT63RZvnaVjdKusCIm6QmAqyLx8s
        NQGHkLOrYRRpKG9R7xF793kuDRkd4+a3T7IQL6wLXks1NE1C3+2MJbdQASSffDI3WthpTH
        lqafpOw5lAIA66C3OpHAEjtmZMu+ycQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-zpzJXMjQNt-1IH2FUjaqQg-1; Mon, 16 Jan 2023 09:08:19 -0500
X-MC-Unique: zpzJXMjQNt-1IH2FUjaqQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CA7438123BE;
        Mon, 16 Jan 2023 14:08:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 778DF40C2064;
        Mon, 16 Jan 2023 14:08:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com>
References: <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com> <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com> <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com> <CPQQLU1ISBIJ.2SHU1BOMNO7TY@bobo>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Nicholas Piggin <npiggin@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, tony.luck@intel.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Jan Glauber <jan.glauber@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Memory transaction instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1966766.1673878095.1@warthog.procyon.org.uk>
Date:   Mon, 16 Jan 2023 14:08:15 +0000
Message-ID: <1966767.1673878095@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

I'm not sure how relevant it is to the topic, but I seem to remember you
having a go at implementing spinlocks with x86_64 memory transaction
instructions a while back.  Do you have any thoughts on whether these
instructions are ever likely to become something we can use?

I was looking specifically at the skbuff queue stuff which does {
spin_lock_irq, add to list, inc count, spin_unlock_irq } and thinking that
might be a good place to use such a thing.

David

