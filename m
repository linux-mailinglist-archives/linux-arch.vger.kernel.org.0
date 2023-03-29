Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69976CF194
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjC2R7z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 13:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjC2R7x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 13:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7C5240
        for <linux-arch@vger.kernel.org>; Wed, 29 Mar 2023 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680112750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bjdk/0Vi9XEk8rAPBToebWaS2lMtqxl+/fQ8ndI4Fq4=;
        b=Bod03KgU49xxjC+AinAtTmoORXi9iTLeGCnH1qDOHfSmAcL4j/YFagwzf9YP08K7NK8jwa
        3+qa0BeMmPrSJyAWtd6HxVsmhT1e6Zl+jxnvrnCJI2XaasXmyiJnEfuMbSy29tm0sWJ3o6
        Asa4X3JP4SdLFdayCt+EOB2bjakcDXQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-kbDiB8jMMXGxsU4Z-OuJDA-1; Wed, 29 Mar 2023 13:59:04 -0400
X-MC-Unique: kbDiB8jMMXGxsU4Z-OuJDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D201E3C0C8A6;
        Wed, 29 Mar 2023 17:59:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id B68761121330;
        Wed, 29 Mar 2023 17:58:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 29 Mar 2023 19:58:56 +0200 (CEST)
Date:   Wed, 29 Mar 2023 19:58:51 +0200
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
Message-ID: <20230329175850.GA8425@redhat.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <20230329151515.GA913@redhat.com>
 <9a456346-e207-44e1-873e-40d21334e01b@app.fastmail.com>
 <20230329160322.GA4477@redhat.com>
 <ZCO20bzX/IB8J6Gp@memverge.com>
 <20230329171322.GB4477@redhat.com>
 <ZCPOpClZ3hOQCs7a@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCPOpClZ3hOQCs7a@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
> On Wed, Mar 29, 2023 at 07:13:22PM +0200, Oleg Nesterov wrote:
> >
> > -		if (selector && !access_ok(selector, sizeof(*selector)))
> > -			return -EFAULT;
> > -
> >  		break;
> >  	default:
> >  		return -EINVAL;
> >
>
> The result of this would be either a task calling via prctl or a tracer
> calling via ptrace would be capable of setting selector to a bad pointer
> and producing a SIGSEGV on the next system call.

Yes,

> It's a pretty small footgun, but maybe that's reasonable?

I hope this is reasonable,

> From a user perspective, debugging this behavior would be nightmarish.
> Your call to prctl/ptrace would succeed and the process would continue
> to execute until the next syscall - at which point you incur a SIGSEGV,

Yes. But how does this differ from the case when, for example, user
does prtcl(PR_SET_SYSCALL_USER_DISPATCH, selector = 1) ? Or another
bad address < TASK_SIZE?

access_ok() will happily succeed, then later syscall_user_dispatch()
will equally trigger SIGSEGV.

Oleg.

