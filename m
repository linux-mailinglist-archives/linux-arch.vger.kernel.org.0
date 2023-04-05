Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8EE6D82D5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 18:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjDEQDj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 12:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbjDEQDf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 12:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD355FF9
        for <linux-arch@vger.kernel.org>; Wed,  5 Apr 2023 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680710567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h82lgj63761it4Zz6EVQZAD8HXJt6YMzMIKXUxq/7Bs=;
        b=P29N9gyNDRXAQ9pDIT6BDXckEPPLdmFCjYrmHzWAjfWnC1VZj6xk5PpFG5cmqGwcOzquB2
        IO+0jIUkSRTkO6+qBgSgg1quITlDXC2a7X9P/h+VVJ2SACyzF1EtD6APv2AwAgZtNjp8gM
        04lMg7FAzauXOqVTgoBFn5I9noW0wBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-qOVvPJqdMVKCgg9ZnLA2WQ-1; Wed, 05 Apr 2023 12:02:42 -0400
X-MC-Unique: qOVvPJqdMVKCgg9ZnLA2WQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45F2C88B767;
        Wed,  5 Apr 2023 16:02:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 12970400F57;
        Wed,  5 Apr 2023 16:02:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  5 Apr 2023 18:02:32 +0200 (CEST)
Date:   Wed, 5 Apr 2023 18:02:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, arnd@arndb.de,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v15 2/4] syscall user dispatch: untag selector addresses
 before access_ok
Message-ID: <20230405160227.GA13943@redhat.com>
References: <20230330212121.1688-1-gregory.price@memverge.com>
 <20230330212121.1688-3-gregory.price@memverge.com>
 <ZCYP+4gRZDqC0lRo@arm.com>
 <20230404104506.GA24740@redhat.com>
 <ZCxfdC+v4v6EEy4v@arm.com>
 <ZC1UEK43yOsXKvi4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC1UEK43yOsXKvi4@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 04/05, Catalin Marinas wrote:
>
> > Yes, from the security perspective, but there are ABI implications.

Thanks a lot for your explanations.

To be honest, I am still a bit confused... Will try to grep the relevant code.
But as for this patch, now I believe it is correct.

So, FWIW,

Acked-by: Oleg Nesterov <oleg@redhat.com>

