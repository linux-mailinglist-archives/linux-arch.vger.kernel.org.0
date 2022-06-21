Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0D553049
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 12:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348886AbiFUK6l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 06:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348880AbiFUK6k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 06:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4034729349
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2022 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655809118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hy6KOcY0sRAojRWcsjR0aWULa6jJaSKcS71iuLiH50w=;
        b=iusCzojIFFVM6oa1nWOZBJYrtg4ogVRpT7U2u1VTc0utnGfb2qDpB+3SOUEgQ4h+BmfzAz
        EdWN0dnpGEUZCn/OPhc1hUCruHZTFGE+FBk+lf74kQ77+0+nG1MQ8jXNZ3R2M71L1OUN2y
        sh7Cdt69Y94w0z+1dtxo+r+FPypNp4g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-WzjmQB9zNRa7eiyrfXXRvQ-1; Tue, 21 Jun 2022 06:58:27 -0400
X-MC-Unique: WzjmQB9zNRa7eiyrfXXRvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8F69299E773;
        Tue, 21 Jun 2022 10:58:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F239C2166B26;
        Tue, 21 Jun 2022 10:58:24 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Cyril Hrubis <metan@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, arnd@arndb.de,
        linux-api@vger.kernel.org, dhowells@redhat.com,
        David.Laight@aculab.com, zack@owlfolio.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v2] uapi: Make __{u, s}64 match {u, }int64_t in
 userspace
References: <20220621090951.29911-1-metan@ucw.cz>
Date:   Tue, 21 Jun 2022 12:58:23 +0200
In-Reply-To: <20220621090951.29911-1-metan@ucw.cz> (Cyril Hrubis's message of
        "Tue, 21 Jun 2022 11:09:51 +0200")
Message-ID: <877d5a1dww.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Cyril Hrubis:

> From: Cyril Hrubis <chrubis@suse.cz>
>
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace.
>
> This allows us to use the kernel structure definitions in userspace.
>
> For example we can use PRIu64 and PRId64 modifiers in printf() to print
> structure membere. Morever with this there would be no need to redefine
> these structures in an libc implementations as it is done now.
>
> Consider for example the newly added statx() syscall. If we use the
> header from uapi we will get warnings when attempting to print it's
> members as:
>
> 	printf("%" PRIu64 "\n", stx.stx_size);
>
> We get:
>
> 	warning: format '%lu' expects argument of type 'long unsigned int',
> 	         but argument 5 has type '__u64' {aka 'long long unsigned int'}
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Could you add some motivation for the C++ condition to the commit
message?

Thanks,
Florian

