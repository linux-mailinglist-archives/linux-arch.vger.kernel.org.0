Return-Path: <linux-arch+bounces-12160-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B6AAC94F1
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 19:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6232C1BC62B1
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A192D267AE3;
	Fri, 30 May 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQc020xD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836C267AF4
	for <linux-arch@vger.kernel.org>; Fri, 30 May 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627202; cv=none; b=Muh17px2hFU21ib3M/nf5oN+5BOXpHwUaIBFQwPHmZJYQRaIo2YWjuLRHeK/GVycPgWfyDdT398FqbVF5kGhRIBho/Y3cyG2LWW793tayiYGsDEcaZwb6Ll0VLZMIFHuinTrsc1lOON+00tNPpyDY3ATsGY3FRLm81nE2vQVfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627202; c=relaxed/simple;
	bh=8/rRsYd5JSLeJh6AS9GM17uwsqHj9NnqSj1CiHBfh1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBTWAypGphDRoIZMlWEl1ZqJDWP36m2MurWuIFoItpVECLa4HSyc/iUw2TwDYxd2uY057gS/CSf8im0W6AiZSAOhds3sb0skuLqsfYzpVHCHkdSZCNsa5FmElqkFAqUqGScvxFyd4vAmA8dpNEacD02830OjnrhNVEJ0e/BgkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQc020xD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-601a67c6e61so1099a12.0
        for <linux-arch@vger.kernel.org>; Fri, 30 May 2025 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748627199; x=1749231999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihn3lqu8Zt6o9S0Gm/cjJQZ8oEZNZXj7TjU4dT1ISYE=;
        b=bQc020xDvzIaFIL3v9Jg0LyaBSrXH2yW4ppEHZi3DYPfh8IPlXZRzGoehKPw7LCHET
         L0SLyRaTjkgkjC2q7oKEJhKciSFq/54enx8+T+SMxidHVyyDO1MxwEyM519EcqJAbLiy
         +9aWQ6jh097lZk6me03TlWUHExTspu2XqKyZ0Kdaj/3v4ojWdOZ/lc+ulqltquHiFPH1
         oowKDkWbMK5DVzntCJUXEbQ3azETloXFzL2E3G4pbxCuUKL77I9NRsu88TnbqQNDqPgK
         wig8AmGN2iOfvSupK1Yit99xEC+WGsR8zFzbSu70u/4Ja1sjF/+Jh0Yq1N6UaFZ/NhxI
         WHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748627199; x=1749231999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihn3lqu8Zt6o9S0Gm/cjJQZ8oEZNZXj7TjU4dT1ISYE=;
        b=pEBBJI602R+wF/e6j0/8zjrjcVEBnChGIKAcWaJHJIaRP17ToOYGbZW6ZJY9aqNpJt
         BiJ8qM8QOnxiPI1//bZ+LmDDca7ixy8Fd5deG9+KBP3xhrOLKHpdqP7dRMjUlyIKngHp
         ke20RhDzJvbSCmSZIDsA3iu6b3+0+bQgJugplNSWgwK1EhzlDQylUCayCzMyTtFx+hhE
         V2ajYJ8wx74Wrdte7aX5NZ0BZXnbjrlDrLXcIaqT8gIoXgt/tRm465u1WmpbIL+Bs1lG
         qjIKRbsRzHvFaajf90gxxT2nbx5hr7q7rnMOzjLu6JM7qYqrVVrERH7wRGUvKl6Wmj3/
         8Q7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxo47Yy9DUsZUxwDk4ZqQm/HOdXJGr5i9+HffTpboj8/kKSQlVRG0l1l9DSHWGKgvGvn06M4YOTEon@vger.kernel.org
X-Gm-Message-State: AOJu0YyXaf8MZHLX3veA0vw9UMXmis1Au4yBQKzumlPcO3+4C52T9qml
	2hEEUAXWQHhnuojLGmofo5xdFjeZt8+nJkn8imZ6DxKWV46eMGLI4saFc/PmxeOk2CRO/nQKyLL
	OzP5zUhbgcfqv4X9iPM4WKJi01xr4q6oy7zyhbgdH
X-Gm-Gg: ASbGncv0S+c90WpvtSGnmXy4REZuMT8X4bYL1VJ9y+zysT7nTMkvFVdQPgf9nk/s7Ls
	PiLDWCR9eA6Rrk2Anwf2ypWRD5eFxE0sxIcyEA8b++UT0ABAc5OYF/qHxd5Aj8/10Wy744pbWDW
	Cvn/bhRI+pCAgvkhO+uvpkQXHhE9of7OQaN2u6REdovfvZjix7xKbIElJr2qT/qjSoh1fxwrs=
X-Google-Smtp-Source: AGHT+IFlIzSWLpiRPWX4PVcfGklgRFG+QAA+iehSSjEDDk9XEYQUHXFbDDpIGgjFzNVjN6xbkHl/xyDhsDUsEr6S+OI=
X-Received: by 2002:aa7:d5ce:0:b0:604:5b98:7c9b with SMTP id
 4fb4d7f45d1cf-605accfe0b1mr1879a12.0.1748627198767; Fri, 30 May 2025 10:46:38
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404021902.48863-1-anthony.yznaga@oracle.com>
 <20250404021902.48863-9-anthony.yznaga@oracle.com> <CAG48ez3cUZf+xOtP6UkkS2-CmOeo+3K5pvny0AFL_XBkHh5q_g@mail.gmail.com>
 <bd7d2ebe-f9be-437f-8cd8-683c809326f1@oracle.com>
In-Reply-To: <bd7d2ebe-f9be-437f-8cd8-683c809326f1@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 30 May 2025 19:46:02 +0200
X-Gm-Features: AX0GCFtcbPmabOKu0l_GvwpOc7YrLnX_imk60FuH-p4r20hytH-nZKj_S8c80B0
Message-ID: <CAG48ez3TTicKSxXyScmqq5Gg91+-KCSk80EccwkbvsQjLzjCFA@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] mm/mshare: flush all TLBs when updating PTEs in
 an mshare range
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, 
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 6:30=E2=80=AFPM Anthony Yznaga
<anthony.yznaga@oracle.com> wrote:
> On 5/30/25 7:41 AM, Jann Horn wrote:
> > On Fri, Apr 4, 2025 at 4:18=E2=80=AFAM Anthony Yznaga <anthony.yznaga@o=
racle.com> wrote:
> >> Unlike the mm of a task, an mshare host mm is not updated on context
> >> switch. In particular this means that mm_cpumask is never updated
> >> which results in TLB flushes for updates to mshare PTEs only being
> >> done on the local CPU. To ensure entries are flushed for non-local
> >> TLBs, set up an mmu notifier on the mshare mm and use the
> >> .arch_invalidate_secondary_tlbs callback to flush all TLBs.
> >> arch_invalidate_secondary_tlbs guarantees that TLB entries will be
> >> flushed before pages are freed when unmapping pages in an mshare regio=
n.
> >
> > Thanks for working on this, I think this is a really nice feature.
> >
> > An issue that I think this series doesn't address is:
> > There could be mmu_notifiers (for things like KVM or SVA IOMMU) that
> > want to be notified on changes to an mshare VMA; if those are not
> > invoked, we could get UAF of page contents. So either we propagate MMU
> > notifier invocations in the host mm into the mshare regions that use
> > it, or we'd have to somehow prevent a process from using MMU notifiers
> > and mshare at the same time.
>
> Thanks, Jann. I've noted this as an issue. Ultimately I think the
> notifiers calls will need to be propagated. It's going to be tricky, but
> I have some ideas.

Very naively I think you could basically register your own notifier on
the host mm that has notifier callbacks vaguely like this that walk
the rmap of the mshare file and invoke nested mmu notifiers on each
VMA that maps the file, basically like unmap_mapping_pages() except
that you replace unmap_mapping_range_vma() with a notifier invocation?

static int mshare_mmu_notifier_invalidate_range_start(struct mmu_notifier *=
mn,
    const struct mmu_notifier_range *range)
{
  struct vm_area_struct *vma;
  pgoff_t first_index, last_index;

  if (range->end < host_mm->mmap_base)
    return 0;
  first_index =3D (max(range->start, host_mm->mmap_base) -
host_mm->mmap_base) / PAGE_SIZE;
  last_index =3D (range->end - host_mm->mmap_base) / PAGE_SIZE;
  i_mmap_lock_read(mapping);
  vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index, last_index)=
 {
    struct mmu_notifier_range nested_range;

    [... same math as in unmap_mapping_range_tree ...]
    mmu_notifier_range_init(&nested_range, range->event, vma->vm_mm,
nested_start, nested_end);
    mmu_notifier_invalidate_range_start(&nested_range);
  }
  i_mmap_unlock_read(mapping);
}

And ensure that when mm_take_all_locks() encounters an mshare VMA, it
basically recursively does mm_take_all_locks() on the mshare host mm?

I think that might be enough to make it work, and the rest beyond that
would be optimizations?

