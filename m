Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D4968DA4F
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 15:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBGORJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 09:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjBGORI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 09:17:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A01412061
        for <linux-arch@vger.kernel.org>; Tue,  7 Feb 2023 06:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675779374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpL7xLToQHaBruNrQ6jvsEn58M8HRkbgtnnVi3id2K4=;
        b=T39KTlTyc8rfQta3ZTveHpDKyCWtp6xIySP74sJ+bqhD/EVCh8UcAyZl5aAsKLBpH2Fpu0
        s0M7BOw7/3GJnWLPOZrLa0VBZND9UFcox0xmg/PNw3iCQkvfiVW0qOQdYvby0qMikj2wJ/
        RPxIoUQcF4o9Qyg3bTxgdcrnZ6JZH1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-ZcaFi-qAM2Snooblg4wSLQ-1; Tue, 07 Feb 2023 09:16:13 -0500
X-MC-Unique: ZcaFi-qAM2Snooblg4wSLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AE16101B42B;
        Tue,  7 Feb 2023 14:16:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29AC5C15BA0;
        Tue,  7 Feb 2023 14:16:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000003b4f6805f3dfe31d@google.com>
References: <0000000000003b4f6805f3dfe31d@google.com>
To:     syzbot <syzbot+d87dd8e018fd2cc2528b@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        npiggin@gmail.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [syzbot] kernel BUG in __tlb_remove_page_size (2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3151378.1675779370.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 07 Feb 2023 14:16:10 +0000
Message-ID: <3151379.1675779370@warthog.procyon.org.uk>
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

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-=
fs.git/ iov-fixes

