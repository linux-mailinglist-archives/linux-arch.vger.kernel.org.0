Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18B6CF1EA
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 20:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjC2SOQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 14:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjC2SOP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 14:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF46469E
        for <linux-arch@vger.kernel.org>; Wed, 29 Mar 2023 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680113613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G6JR04Y31JkOnHXtliMdyMd58PkIetl6DHdJ9Oi1Gl0=;
        b=UQYGnUMjIFG/S92Ir1tpiFMqQM4X2QSYEP05zXOFg3njGiZPD2qm8ipw2fT0fQXSxgMo2d
        VPH1b1Omp3MvVLEcd5oIwWL5jN0lXHrxc2k4nBlAW7mahXXs1FnqjdpIUMycIndGI7Wd0R
        sywDY1oSYNGzi918f6ZBxaPNK+HY2zc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-OgVkv27qP_GODukLdueJ5Q-1; Wed, 29 Mar 2023 14:13:28 -0400
X-MC-Unique: OgVkv27qP_GODukLdueJ5Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47A371C05139;
        Wed, 29 Mar 2023 18:13:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id D060E492B00;
        Wed, 29 Mar 2023 18:13:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 29 Mar 2023 20:13:05 +0200 (CEST)
Date:   Wed, 29 Mar 2023 20:13:00 +0200
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
Message-ID: <20230329181300.GB8425@redhat.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <20230329151515.GA913@redhat.com>
 <9a456346-e207-44e1-873e-40d21334e01b@app.fastmail.com>
 <20230329160322.GA4477@redhat.com>
 <ZCO20bzX/IB8J6Gp@memverge.com>
 <20230329171322.GB4477@redhat.com>
 <ZCPOpClZ3hOQCs7a@memverge.com>
 <20230329175850.GA8425@redhat.com>
 <ZCPSnVgvyv3uaAKY@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCPSnVgvyv3uaAKY@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
> Am I ok to add your signed-off-by to the suggested patch, and i'll add
> it to the series?  Not quite sure what the correct set of tags is,
> since i don't have any suggested changes to your patch.

Feel free to add my SOB, but probably Suggested-by: make more sense.

Oleg.

