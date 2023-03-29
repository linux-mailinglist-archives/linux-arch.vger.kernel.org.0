Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9117A6CF7CC
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 01:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjC2Xzs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 19:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjC2Xzr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 19:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9263259DA
        for <linux-arch@vger.kernel.org>; Wed, 29 Mar 2023 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680134101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDvzU53CPeswLit/FMHu3YOxwiNaBZwdjQxKehJieKw=;
        b=XF35G6+5gVpLlCqkKhTBABjypRQn5+pr79iRSgxyIAmVnLi+L8eIzmHgmKE1tGI6gs1k2s
        xBmQLMu6SxIbzZrmxfrHiACfJMIxFLQrj0j63HkQp/AxEnQsVU3JPNzubZO1w0HsMekQr7
        ld5gVPNFos7MVkOqQcZ+Lk2hfmn5KSE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-gjbwPLEMPuu8BeS56HR0nQ-1; Wed, 29 Mar 2023 19:54:56 -0400
X-MC-Unique: gjbwPLEMPuu8BeS56HR0nQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C88EE3C0DDA1;
        Wed, 29 Mar 2023 23:54:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id AFE50492C3E;
        Wed, 29 Mar 2023 23:54:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 30 Mar 2023 01:54:48 +0200 (CEST)
Date:   Thu, 30 Mar 2023 01:54:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, avagin@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, krisman@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, shuah <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, tongtiangen@huawei.com,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of
 access_ok
Message-ID: <20230329235442.GA10790@redhat.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <20230329151515.GA913@redhat.com>
 <9a456346-e207-44e1-873e-40d21334e01b@app.fastmail.com>
 <20230329160322.GA4477@redhat.com>
 <ZCO20bzX/IB8J6Gp@memverge.com>
 <20230329171322.GB4477@redhat.com>
 <ZCPOpClZ3hOQCs7a@memverge.com>
 <20230329175850.GA8425@redhat.com>
 <ZCQMsWNfkMJ0xHSy@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCQMsWNfkMJ0xHSy@memverge.com>
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

On 03/29, Gregory Price wrote:
>
> Last note on this before I push up another patch set.
>
> The change from __get_user to get_user also introduces a call to
> might_fault() which adds a larger callstack for every syscall /
> dispatch.  This turns into a might_sleep and might_reschedule, which
> represent a very different pattern of execution from before.

might_fault() is nop unless CONFIG_PROVE_LOCKING || DEBUG_ATOMIC_SLEEP.

Again, I won't really argue with task_access_ok(). Just I am not sure
2/4 gives enough justification for this new helper with unclear semantics
(until we ensure that access_ok() doesn't depend on current).

Oleg.

