Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D76B7E6E
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391380AbfISPmb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:42:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389646AbfISPma (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Sep 2019 11:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568907749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=jtOOTxtBSH0XScdrTXtYNsOa16spVRV1/m7O55QYuzg=;
        b=IcXStEpMdiQ7LtTF3y43ldGKSi9PVKlJkwojgu7jq1Ey17kl0EwJym67jOEGyzRm9ol3xe
        kUkW7jbbCT/+VU7OXdCsIsQxtgkMuFQsOf9mgRs5ThXAiIQ1FIIq0XMNTxlMLCBIgqY6Qz
        pbk9LJILPy6PQQGRZlJpouUd60mjsUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-a8uy-n9oN3qXq4wH1ZFgRw-1; Thu, 19 Sep 2019 11:40:57 -0400
Received: by mail-wm1-f70.google.com with SMTP id g82so1988871wmg.9
        for <linux-arch@vger.kernel.org>; Thu, 19 Sep 2019 08:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bAINjjRSlbUTjobcIGuJ8vNAwyPobHG3I1/jgsCdgXw=;
        b=iuspiW79K3BUxeKSsaaroNaa99PqrtjHbe2yh0Uro7eGG9wXBCIC28MKht35MkqqOh
         SY6Vd5eTud/GScKhIEfjh9kmkMeK5CnVZB4ginw+Wbg2zgXAyC59qbE05BTQ3mf0E+PK
         sfhN3ZFxswiRcA4zDVe0FH4wC7w8JTs5KhB1eXyNCk8QzaArJZu+ibc0DTRPhI+BT3O6
         pF9o17pPo3cyaqQ0AUp/Xi/AetwmO7iLyN2WXbYbZLI9LJruR8WJIymqBM3s2mXZLAXc
         h2G3qprc5+AlR403AvxEk46WADiS0EXSFfUQO3Y08UQzIYRgF4J45zI6Om+zbQ7A4e2I
         w+ww==
X-Gm-Message-State: APjAAAVdX4v+vv+1x/JM2rW+ea227X6DnZF+kF7xuecAN6CId3qjUlPG
        ohkwAn3OSHgbw0jfKrYhoc7RhiJTfnoBSWXG8sOlHneLjXOkhBhRyBBAcyRr8UhG82Uk3s5Y+VA
        UiznmaErNigBd3GwMzKzHXw==
X-Received: by 2002:adf:e488:: with SMTP id i8mr7375474wrm.20.1568907653242;
        Thu, 19 Sep 2019 08:40:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwR9KVma4Xblc47G5SpP/XvO6PKkeiTk0NhW+haXvKEfP9pKSHtsHzJm0BanCJIZYw+ZParUA==
X-Received: by 2002:adf:e488:: with SMTP id i8mr7375450wrm.20.1568907652977;
        Thu, 19 Sep 2019 08:40:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id t6sm9820328wmf.8.2019.09.19.08.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 08:40:52 -0700 (PDT)
Subject: Re: [RFC patch 15/15] x86/kvm: Use GENERIC_EXIT_WORKPENDING
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
 <20190919150809.964620570@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ef1145d8-01af-57d2-1065-cf12db16e422@redhat.com>
Date:   Thu, 19 Sep 2019 17:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919150809.964620570@linutronix.de>
Content-Language: en-US
X-MC-Unique: a8uy-n9oN3qXq4wH1ZFgRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19/09/19 17:03, Thomas Gleixner wrote:
> Use the generic infrastructure to check for and handle pending work befor=
e
> entering into guest mode.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Subject should be "x86/kvm: use exit_to_guestmode".

Paolo

> ---
>  arch/x86/kvm/x86.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>=20
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -52,6 +52,7 @@
>  #include <linux/irqbypass.h>
>  #include <linux/sched/stat.h>
>  #include <linux/sched/isolation.h>
> +#include <linux/entry-common.h>
>  #include <linux/mem_encrypt.h>
> =20
>  #include <trace/events/kvm.h>
> @@ -7984,8 +7985,8 @@ static int vcpu_enter_guest(struct kvm_v
>  =09if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
>  =09=09kvm_x86_ops->sync_pir_to_irr(vcpu);
> =20
> -=09if (vcpu->mode =3D=3D EXITING_GUEST_MODE || kvm_request_pending(vcpu)
> -=09    || need_resched() || signal_pending(current)) {
> +=09if (vcpu->mode =3D=3D EXITING_GUEST_MODE || kvm_request_pending(vcpu)=
 ||
> +=09    exit_to_guestmode_work_pending()) {
>  =09=09vcpu->mode =3D OUTSIDE_GUEST_MODE;
>  =09=09smp_wmb();
>  =09=09local_irq_enable();
> @@ -8178,17 +8179,9 @@ static int vcpu_run(struct kvm_vcpu *vcp
> =20
>  =09=09kvm_check_async_pf_completion(vcpu);
> =20
> -=09=09if (signal_pending(current)) {
> -=09=09=09r =3D -EINTR;
> -=09=09=09vcpu->run->exit_reason =3D KVM_EXIT_INTR;
> -=09=09=09++vcpu->stat.signal_exits;
> +=09=09r =3D exit_to_guestmode(kvm, vcpu);
> +=09=09if (r)
>  =09=09=09break;
> -=09=09}
> -=09=09if (need_resched()) {
> -=09=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> -=09=09=09cond_resched();
> -=09=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> -=09=09}
>  =09}
> =20
>  =09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
>=20
>=20

