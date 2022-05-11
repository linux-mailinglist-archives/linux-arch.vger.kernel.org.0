Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F53523883
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbiEKQRn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 12:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344657AbiEKQRe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 12:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B61033A5DE
        for <linux-arch@vger.kernel.org>; Wed, 11 May 2022 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652285839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ch8AYJSR0bVojuLA0JpsnHZw3evm/2ziMe/ALgDSt0o=;
        b=EKytlTL8swFM6qUYjHx/HvzwFj6Y5apgLPJYsTTF7ku62nenOu4fyjn55vaElF2pkPWyoq
        dOCmorhVXyatq3sPTdTuVlwMvjNajxevdhkVFvMe3Za/ldGDndxmqyq14TrzirvRkX8xs0
        FxPdvWWWOj/sIU+G3s/y0J895x/KLrI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-gvGzGxhpO0KBaP3E_N9zzA-1; Wed, 11 May 2022 12:17:16 -0400
X-MC-Unique: gvGzGxhpO0KBaP3E_N9zzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C32A380418F;
        Wed, 11 May 2022 16:17:15 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D295640CF8E4;
        Wed, 11 May 2022 16:17:10 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH V9 13/24] LoongArch: Add system call support
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
        <20220430090518.3127980-14-chenhuacai@loongson.cn>
        <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
        <CAAhV-H4te_+AS69viO4eBz=abBUm5oQ6AfoY1Cb+nOCZyyeMdA@mail.gmail.com>
        <CAK8P3a0DqQcApv8aa2dgBS5At=tEkN7cnaskoUeXDi2-Bu9Rnw@mail.gmail.com>
        <20220507121104.7soocpgoqkvwv3gc@wittgenstein>
        <20220509100058.vmrgn5fkk3ayt63v@wittgenstein>
Date:   Wed, 11 May 2022 18:17:09 +0200
In-Reply-To: <20220509100058.vmrgn5fkk3ayt63v@wittgenstein> (Christian
        Brauner's message of "Mon, 9 May 2022 12:00:58 +0200")
Message-ID: <87bkw4doxm.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Christian Brauner:

> Without an approach like this certain sandboxes will fallback to
> ENOSYSing system calls they can't filter. This is a generic problem
> though with clone3() being one promiment example.

Furthermore, for glibc (and I believe musl as well), the trick with
in-process emulation of clone3 using SIGSYS does not work here because
we must inhibit delivery of signals on the nascent thread, before it is
fully set up.  This means that we have to block signals around the
clone/clone3 system call, so that the new thread is created with all
signals blocked.  This means that instead of calling the SIGSYS handler,
the filtered system call simply terminates the process.

(I think there have been discussions of using out-of-process filtering,
but I don't know where we are with that.)

Thanks,
Florian

