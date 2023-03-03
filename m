Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF866A9522
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 11:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjCCKZx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 05:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCCKZw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 05:25:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89F1E2A4
        for <linux-arch@vger.kernel.org>; Fri,  3 Mar 2023 02:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677839104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9+wnViAfgRGxceAvmgnjlQOz7O3uUoD7hSzCtJvw3Y=;
        b=HOWGtRaxmucPwUbKj4BU+Hdg2sJN6a4zjf589DXBa6HVD/epm/QIhjuVpCe604KByL+KOe
        trTBh67oukbr2jRvap9uR7k8yecUzZ3cpCnBH2K1RiHAH7fqiI6iwifx7avUi/lvhQbf8O
        ZMSabElTx6iiuX1yss3eebjAq1AVGKs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-jYAjJAqMNjS4Sff43e3n6Q-1; Fri, 03 Mar 2023 05:24:58 -0500
X-MC-Unique: jYAjJAqMNjS4Sff43e3n6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FEE6800B23;
        Fri,  3 Mar 2023 10:24:58 +0000 (UTC)
Received: from localhost (ovpn-13-150.pek2.redhat.com [10.72.13.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59BE6C16900;
        Fri,  3 Mar 2023 10:24:56 +0000 (UTC)
Date:   Fri, 3 Mar 2023 18:24:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, geert@linux-m68k.org,
        hch@infradead.org
Subject: Re: [PATCH v2 0/2] arch/*/io.h: remove ioremap_uc in some
 architectures
Message-ID: <ZAHK8kvYzrZfvyBo@MiWiFi-R3L-srv>
References: <20230301102208.148490-1-bhe@redhat.com>
 <ZAD/jLaacr0Xu+/M@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAD/jLaacr0Xu+/M@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/02/23 at 11:57am, Luis Chamberlain wrote:
> On Wed, Mar 01, 2023 at 06:22:06PM +0800, Baoquan He wrote:
> > This patchset tries to remove ioremap_uc() in the current architectures
> > except of x86 and ia64. They will use the default ioremap_uc definition
> > in <asm-generic/io.h> which returns NULL.
> > 
> > If any arch sees a breakage caused by the default ioremap_uc(), it can
> > provide a sepcific one for its own usage.
> 
> Feel free to add:
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks for check. I made some changes according to comments, will repost.
Please help review.

