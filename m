Return-Path: <linux-arch+bounces-3523-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261FE89DE17
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8ACF294671
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F2412F36B;
	Tue,  9 Apr 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kbyIdd4w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fB+VxKTC"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B396131E4B;
	Tue,  9 Apr 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675114; cv=none; b=hW+djoaqEUSphvtegYC9pCIX4WsfwXT0OjW0RXO8pAbYvA3q8QmmCc/A4CBzvWOgF8s9nuqAdJ7MGZIpjno6+CE1fL06yr6XNg4nxmhAcVOZoTq+n9EbN5e4IhJRYbwFud3Cq3l4Tb+FFNV2gD7VuannB3dgtkRSZj5lRFhgmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675114; c=relaxed/simple;
	bh=V6madtNyWdhTt9y9c6a6ZrnVncckkEUPl1Vv6/BK8EA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=a3Qmwb81mqelUxr+Te++urWgAt2WIgz6PbgRYHifjyCjuxeJQYdgvv0TzHEuK2+Ua6BGu3JuS2d541Me22ye59nwr1za+77fmZeNkZ1wyFYN2BomIDzrjX5OIXUPI2D9ugdIlc/GiQu4mtAyQAuVJrZS9MX7ZVyTveaex3PCvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kbyIdd4w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fB+VxKTC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ACD9C114019F;
	Tue,  9 Apr 2024 11:05:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute2.internal (MEProxy); Tue, 09 Apr 2024 11:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712675111; x=1712761511; bh=V6madtNyWd
	hTt9y9c6a6ZrnVncckkEUPl1Vv6/BK8EA=; b=kbyIdd4wjpKM/gTCylL1w1ytKN
	ugmaHUHp9TFSUTKagB9R8Elv67DZAn3PneCEsqWNFH0YxrYTsWsHyI4dEe2AXfdm
	jROAlz5r0xErkOuobwoSinRujrfhxjZLMvj0rye43IootA3QkswUsGbELcjq6J5P
	n7q52Bz1R3ypEWz3sPykXycY4ip6kelo44Kj4tMYaVSeXQHFnA5CJc16CyMM4moX
	dA9IL4B8cgJB/DJORNBRDKpcOrgHJ/42iLF0AdUidh/NMWFyHVM0fJ7vEIQvkj55
	QN2gudXQceSsY9EwUsmGKrGnz3GWVBBJbj4xON7efCGNTpsgC7J66if7TPrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712675111; x=1712761511; bh=V6madtNyWdhTt9y9c6a6ZrnVncck
	kEUPl1Vv6/BK8EA=; b=fB+VxKTCqbxmFLOdr5crCTZ3J5nLE4ks0UrcGXqlc9V0
	uS3ADHT8rS0aRmJlWxpYnXefFf9tZosXG0tCzHSHyV76cpcVTb9RfcPL5lfwMqAZ
	IbUMb1eBLY0Y6vE/92cj/nnCcoyyLMXa+cXCbmdWGK1Rasf8WFQ3NsgGl+2HhahE
	3lAkqS/PXz4ZQRuw9iDXYoByupQ4g2x1hjTbf4kuMRNQjazrjDD1T4+7K22nH9Vu
	CY9mqlSd5ceoFVkBz6lo4YwG18RtLtMdhnSMlTF7ZdxEQL+fAGL+nOnHB0SrDgEs
	qkbYQJNhvDpFwUV9TQs7Qt2JgI9XSUcaPzVN83cjwg==
X-ME-Sender: <xms:J1kVZkGJ_rcgZOh4SmzUXxDCulhR54CuplgFi-RCAg7slankBwfsiA>
    <xme:J1kVZprDR67Xp5IhpoXDKP0SVqR-lrcxghB1esS7_UpdvfDZjFzItyKF489Mwcsv5
    GqV91yWI-wzDh9kzBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:J1kVZg6uQZuzxxjChOWFntNgaF1glK_RoaBaxU6b3PzitRmQx7igHA>
    <xmx:J1kVZn5P045DmgD9Zg-vuljp1A0oiQlSDOe_XnvmgjSxX3qHH5HeRw>
    <xmx:J1kVZtEC1Wmpgi4u3Q32E6hiNgZgfjpS1qQot2FYczZ_qZiRoujUjQ>
    <xmx:J1kVZgRCwG5ZfeMHa0hg1WRzQf4u5LFRwbOPPzuHtz_dco7iSRNggQ>
    <xmx:J1kVZtC59ksjutW5_9lJrNkJ6dKmLbgyfyX_WiQ-WsMJbnsEav7Y6VLT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0D78EB6008D; Tue,  9 Apr 2024 11:05:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <328afce9-345e-4d25-a8c0-f6630112f674@app.fastmail.com>
In-Reply-To: <20240409150132.4097042-7-ardb+git@google.com>
References: <20240409150132.4097042-5-ardb+git@google.com>
 <20240409150132.4097042-7-ardb+git@google.com>
Date: Tue, 09 Apr 2024 17:04:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ard Biesheuvel" <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, "Andrii Nakryiko" <andrii@kernel.org>
Subject: Re: [PATCH v2 2/3] vmlinux: Avoid weak reference to notes section
Content-Type: text/plain

On Tue, Apr 9, 2024, at 17:01, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Weak references are references that are permitted to remain unsatisfied
> in the final link. This means they cannot be implemented using place
> relative relocations, resulting in GOT entries when using position
> independent code generation.
>
> The notes section should always exist, so the weak annotations can be
> omitted.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

