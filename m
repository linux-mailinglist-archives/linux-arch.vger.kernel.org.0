Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A8B7E60
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390004AbfISPk1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:40:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22421 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389893AbfISPk1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Sep 2019 11:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568907622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=40X0vm8+7OBVX9kW6gTq2puO5TD3LRpWUOSeujBTwSI=;
        b=J9KDLVre5Zjyd96KTrWMJIyVjbbF90oTAmyy1QjRNJq9vHovKzx/J1LN/H7bkK40QVVO7o
        vBeg48dp9nsCzERrj0GgiWTTDWldVg8mtmc9cXH6PcXgQfk0LhwPYPSJmVon6As91bk2BG
        y7pukgo+EkH4IpHPFTLdGchk+Pi8zic=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-tVkXXyx5MB-XGwdPsGzzcQ-1; Thu, 19 Sep 2019 11:40:12 -0400
Received: by mail-wr1-f70.google.com with SMTP id h6so1238787wrh.6
        for <linux-arch@vger.kernel.org>; Thu, 19 Sep 2019 08:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IuQngF1BoEvQ6fP1U7DbaQBImeULLxoa7zH+YgkADWs=;
        b=p7Qj6rZWFqzQZaQ2O39KgTfkjUO2Vz6qysAtrYmdz0XapBZrtSrYGXKUN2l9SUXCut
         JWFmMS/bVE3Y680GJhQfCo9qXMtuy34pg+A65CLGvx1zKxRUb2kELiyQ04MS4fincOFv
         JYuHHgM1LOj8fX3ORTJG3M1jEIRhFvfyIaL+FagR1AidrnRwVCsLzealYDLTttrhrah1
         EcHVbRWKnMe6NEYa0DJAhZO9Ve7QzN2VoeLovJ5E1FFtQxmESM9tR8yYMQoC2/whL0po
         qX046s30AF3c83j3X2swXNVWj4LeMBSWKHk0zbZ8JwxQ7q1N75gu3hSM/ybZSWFjSjV+
         f0kA==
X-Gm-Message-State: APjAAAV54O6vGo/NN+coY72G/j31SYP9H6jHj6o+djJf/fmn/jq+BAb1
        a1cmrCzYTqSSwnNk8IVGwKiNvNwLHf32+wfdIaSJdowMVWFi47dHKo4gVCN1RctjSjK8zrBGyAA
        8AsRPH1yHPMstT7j96LZHtw==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr7581977wrs.106.1568907603865;
        Thu, 19 Sep 2019 08:40:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+OjakhgvaDtsfzFmaFL97O8csbbK+Vo5VIxwaqYYZyJpLvjwzE0u+steLkcP97rvOtdgeNw==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr7581956wrs.106.1568907603602;
        Thu, 19 Sep 2019 08:40:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id y3sm9581998wrw.83.2019.09.19.08.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 08:40:03 -0700 (PDT)
Subject: Re: [RFC patch 14/15] workpending: Provide infrastructure for work
 before entering a guest
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.860645841@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0cc964dc-4d00-05ec-1ed1-f6cee7370d7b@redhat.com>
Date:   Thu, 19 Sep 2019 17:40:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919150809.860645841@linutronix.de>
Content-Language: en-US
X-MC-Unique: tVkXXyx5MB-XGwdPsGzzcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Quick API review before I dive into the implementation.

On 19/09/19 17:03, Thomas Gleixner wrote:
> +=09/*
> +=09 * Before returning to guest mode handle all pending work
> +=09 */
> +=09if (ti_work & _TIF_SIGPENDING) {
> +=09=09vcpu->run->exit_reason =3D KVM_EXIT_INTR;
> +=09=09vcpu->stat.signal_exits++;
> +=09=09return -EINTR;
> +=09}
> +
> +=09if (ti_work & _TIF_NEED_RESCHED) {
> +=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +=09=09schedule();
> +=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +=09}
> +
> +=09if (ti_work & _TIF_PATCH_PENDING) {
> +=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +=09=09klp_update_patch_state(current);
> +=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +=09}
> +
> +=09if (ti_work & _TIF_NOTIFY_RESUME) {
> +=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +=09=09clear_thread_flag(TIF_NOTIFY_RESUME);
> +=09=09tracehook_notify_resume(NULL);
> +=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +=09}
> +
> +=09/* Any extra architecture specific work */
> +=09return arch_exit_to_guestmode_work(kvm, vcpu, ti_work);
> +}

Perhaps, in virt/kvm/kvm_main.c:

int kvm_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
=09=09=09=09unsigned long ti_work)
{
=09int r;

=09/*
=09 * Before returning to guest mode handle all pending work
=09 */
=09if (ti_work & _TIF_SIGPENDING) {
=09=09vcpu->run->exit_reason =3D KVM_EXIT_INTR;
=09=09vcpu->stat.signal_exits++;
=09=09return -EINTR;
=09}

=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
=09core_exit_to_guestmode_work(ti_work);
=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);

=09return r;
}

and in kernel/entry/common.c:

int core_exit_to_guestmode_work(unsigned long ti_work)
{
=09/*
=09 * Before returning to guest mode handle all pending work
=09 */
=09if (ti_work & _TIF_NEED_RESCHED)
=09=09schedule();

=09if (ti_work & _TIF_PATCH_PENDING)
=09=09klp_update_patch_state(current);

=09if (ti_work & _TIF_NOTIFY_RESUME) {
=09=09clear_thread_flag(TIF_NOTIFY_RESUME);
=09=09tracehook_notify_resume(NULL);
=09}
=09return arch_exit_to_guestmode_work(ti_work);
}

so that kernel/entry/ is not polluted with KVM structs and APIs.

Perhaps even extract the body of core_exit_to_usermode_work's while loop
to a separate function, and call it as

=09core_exit_to_usermode_work_once(NULL,
=09=09=09=09ti_work & EXIT_TO_GUESTMODE_WORK);

from core_exit_to_guestmode_work.

In general I don't mind having these exit_to_guestmode functions in
kvm_host.h, and only having entry-common.h export EXIT_TO_GUESTMODE_WORK
and ARCH_EXIT_TO_GUESTMODE_WORK.  Unless you had good reasons to do the
opposite...

Paolo

