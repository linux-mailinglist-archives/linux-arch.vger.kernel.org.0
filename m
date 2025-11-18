Return-Path: <linux-arch+bounces-14882-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC8EC6BF1A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 00:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CAE772C353
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 23:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80662D6612;
	Tue, 18 Nov 2025 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXB28k4M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2782D5951
	for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507209; cv=none; b=ZIf/OdXj7RfozA+NzNsrEDRzbrpOtauAvrDeZdOVDV67xzcFBWU9sgHPEgXiC2ncIEInnatEF0BdctI/JZyNubGehLQE38EVTsB6Fh+XOXUW/8f0axy9inHDHe/W8NHyJ+1v3gDXPiTxvc4tVPrSS25Zme38P+NpycZFw0b0KgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507209; c=relaxed/simple;
	bh=ipmRe8qt0agqFfR6nOTHk1pjPrcWTo+df9nh9NOd0Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8WTAtDXdT+GRNHfvWJtdI+OfGmyULpzP4vytEwhkzSh56LGtGZ8CAg+yOKIOjH9MXL5thG8tYsJtMWVX91BOPk3vD9Iq4pKzPwcSEPcT0k1DCtdHPRvma2Y34eQFJ8b8K9rYo0l5Yiyp8yRpefGhPSwHDjoR4JyuBziaiXe+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXB28k4M; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee147baf7bso57761cf.1
        for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 15:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763507206; x=1764112006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqoJmdqFf3U4GEe+Jrsv6Bi9CFhXdokrU/qcH+KMhBI=;
        b=tXB28k4MC5LiGXKzZ7L/98nlOU1FFJbsf55sRxG1KJuC6K2uL6beEjVVtek5VoqBYw
         xrapFZrN1QrpwqM2d0whY8gW1Z0tRI7Sbc13ar8GLuu81SW86i85T7A9niO/QsmaBjPJ
         XbZOYgzyiZkLf83k2La8ujOuNHyXUkBLQBcuwvBkeg7tlL9IavkrR7aFT8Yl1E2PPFMF
         o7TE82G1r9bKeYyvKwjYqpFyMMrufRdvPl99w4xEroFPl/QrcWtQy6x/0VBIjaS/xifa
         xgWiWncBUvymDSDCsuebr281FeA5sIT24OjDoax3QJsM9bCXHUplNEwqfGlouqlOtSEP
         s8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763507206; x=1764112006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QqoJmdqFf3U4GEe+Jrsv6Bi9CFhXdokrU/qcH+KMhBI=;
        b=snh8f1ftA3pEqxPqNFQJ9xiit0vrk/3XS4uaZijdlYZ0/MXvHDAAY+aBuisigam4iq
         2KMaiU5PPzG1VHuXae6udh5nFWOvyInV3fFJKGNNkaCJAws0Z8m2d3l70y1ABl0i0tzL
         gOTdQTUgAX6w9042l3h9wVpx+eZNTw52w0LFyk8wwV7Uoe+piHz9gF49ubLaXTvth51j
         U1vKkW/9C4AGolQwfOp2pF5ntbp5rUtlvjkxrzTpl3s2FYlbmBtXnCt3ICsGls0JrwXo
         sU1an6FoYpMEkuiwLYMJ60VmuOtKjti1x5I7AeuakIWT1qJDupt87jepw3Z0K7HshQcq
         1Rdw==
X-Forwarded-Encrypted: i=1; AJvYcCUx2FtoqKJpOE3/1TpobIkhhS8pnysVElTepaMQbv6WJbIaWxjLenUZSSIsoX38dAbzDcidffqnIdIh@vger.kernel.org
X-Gm-Message-State: AOJu0YydQ54M7XoZajpOMgEIsRFO25S/uqxMx5RxOXKN8lt3CrM5+ELm
	42k2jRGKFhPaj7IFPB8rvhf5N4js5xEKI04rBgqpXQONCDgNoDs2my1PIwk2qBqY6dQemq2WUZc
	JmKIPKGAiYOBg8zUTHSzovDue2brgq29G1qMrrMWB
X-Gm-Gg: ASbGnctxfBlsArN5EbOyJxOhZHdFVnSdXWYE0YcIObzZidyHZEnGXQi5CD1zaeaw9ZB
	uxxw42OdY727BAi7RwXdXelIslttwFpA+awYQWT1876aTz/zgrbttoGPpjWKLchjv6nbQc5uXTY
	E9dZzclP8408ObL7nvpynyPN2la9hlS63XGFcpfJ0eD7lIbxv+685oDK0SNUWLl83NWAcQDSN7D
	81f8edktBCvY3+WBMl/yvDK7Snx/nc6RmEqvKB5aTtnXrkrPDO+BGMQepU1jseen1mr1BT7
X-Google-Smtp-Source: AGHT+IF0BORd+YSoGDs7f9en8VdARpBAdyXcnOdJY9yjnFP6mOSJucNkJt8SiXEuwsahBq61b66cNpL43eOj1sbqbLg=
X-Received: by 2002:ac8:58c2:0:b0:4e5:7827:f4b9 with SMTP id
 d75a77b69052e-4ee3fc8ac64mr862391cf.3.1763507205977; Tue, 18 Nov 2025
 15:06:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com> <20251116182839.939139-4-lrizzo@google.com>
 <87seec78yf.ffs@tglx> <87bjl06yij.ffs@tglx> <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
 <878qg37n8p.ffs@tglx> <CAMOZA0+K73YbPqq_vTS2sMkbV-0Fh5GSCt3ABfReV3DYk1CO2g@mail.gmail.com>
 <87pl9fmhe5.ffs@tglx> <CAMOZA0JXv1ERyGOJ8fmwefnc6XKbGGy-E4p_d+BFr6KPzoOUZw@mail.gmail.com>
In-Reply-To: <CAMOZA0JXv1ERyGOJ8fmwefnc6XKbGGy-E4p_d+BFr6KPzoOUZw@mail.gmail.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 19 Nov 2025 00:06:09 +0100
X-Gm-Features: AWmQ_bmt_cv4dsppUwYJiO-HG2sTfl352yiED5hQZY3n_KDVnxlPHU2z2CUW-uw
Message-ID: <CAMOZA0Jj=BYXx1QYxFQRbtmFYfZeQBySqDS6n1skHFEYD=1EZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 7:25=E2=80=AFPM Luigi Rizzo <lrizzo@google.com> wro=
te:
>
> On Tue, Nov 18, 2025 at 5:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> >
> > On Tue, Nov 18 2025 at 11:09, Luigi Rizzo wrote:
> > > ...
> > > (I appreciate the time you are dedicating to this thread)
> >
> > It's hopefully saving me time and nerves later :)
> >
> > > ...
> > That's kinda true for the per interrupt accounting, but if you look at
> > it from a per CPU accounting perspective then you still can handle them
> > individually and mask them when they arrive within or trigger a delay
> > window. That means:
>
> ok, so to sum up, what are the correct methods to do the masking
> you suggest, should i use mask_irq()/unmask_irq() ?

I tried the following instead of disable_irq()/enable_irq().
This seems to work also for posted_msi with no arch-specific code, as
you suggested.

The drain_desc_list() function below should be usable directly with
hotplug remove callbacks.

I still need to figure out if there is anything special needed when
an interrupt is removed, or the system goes into suspend,
while irq_desc's are in the moderation list.

/* run this to mask and moderate an interrupt */
void irq_mod_mask(struct irq_desc *desc)
{
        scoped_irqdesc_get_and_buslock(desc->irq_data.irq,
IRQ_GET_DESC_CHECK_GLOBAL) {
                struct irq_mod_state *ms =3D this_cpu_ptr(&irq_mod_state);

                /* Add to list of moderated desc on this CPU */
                list_add(&desc->mod.ms_node, &ms->descs);
                mask_irq(scoped_irqdesc);
                ms->mask_irq++;
                if (!hrtimer_is_queued(&ms->timer))
                        irq_moderation_start_timer(ms);
        }
}

/* run this on the timer callback */
static int drain_desc_list(struct irq_mod_state *ms)
{
        struct irq_desc *desc, *next;
        uint srcs =3D 0;

        /* Last round, remove from list and unmask_irq(). */
        list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_node) {
                list_del_init(&desc->mod.ms_node);
                srcs++;
                ms->unmask_irq++;
                scoped_irqdesc_get_and_buslock(desc->irq_data.irq,
IRQ_GET_DESC_CHECK_GLOBAL) {
                        unmask_irq(scoped_irqdesc);
                }
        }
        return srcs;
}

cheers
luigi

