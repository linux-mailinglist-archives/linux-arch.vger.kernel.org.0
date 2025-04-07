Return-Path: <linux-arch+bounces-11295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE84A7DBD6
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 13:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D183ADC37
	for <lists+linux-arch@lfdr.de>; Mon,  7 Apr 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0582356A9;
	Mon,  7 Apr 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H11BSTc8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4B226861;
	Mon,  7 Apr 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023917; cv=none; b=QSlNGg24gVaK40npUQjUgUVSyNJOAcGOcITycRDmzL/TafraGfsKBtggMEQ8cGDLGrA1u0X1z/dIyPaW4RV1mtaEnr2idWNM5+n5Oi6nKOdlA52cz7/GZ5fLe62LWWAF4CpDXXNAS6Vgr0ADGjPkRfpWfMZ0yiAqP89q0IRhwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023917; c=relaxed/simple;
	bh=nJCcGwyCZuu6B9cg8mEdqiZn0bZFneyhdJXneM3xqYk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=XCjyc1L3yt02TtdLDrFbCmCrzgPK5+HCI8vViBFy3YQBmqpX8joXR45ghx7qKzslGRG3eLwXa08Slgk2JQPeZAbnx/3skhsOuFNHNGPxjIVMb7Tfi3sHbmB8lIEoWazj5X/Wu71oHiQpaQHoyx4AYBo4AO1rsCBatPOZlf8cHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H11BSTc8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so6887033a12.1;
        Mon, 07 Apr 2025 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744023913; x=1744628713; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOXFkEFTB5SlM6cWWhuxa7vVuGMc7ycBvnouqma9E0c=;
        b=H11BSTc8nE5bnMDE2HXY/NHPSqOuf677RUhlbcOiW0VSVsp/7tMqoivEPcYkXIVKdR
         kv5lH8ZusZO6vhwW5f17rRP8DFlFApDpe6Du0KZ/oZW7eEQCaYsoQ4q7glYw3wKaQuLS
         AO3oMCVwGzqfl+rzErpIv8Hkvzi49MmLer5fstNo0m32Iuz8mly3g27Sc1eYCTPW+tUd
         +t2OlhnFBhFlVpSSOuxuY3veuT8Xodtmi7tdI+b3O5HPOiFY0FJiV4RvAKeoUt60uJ4y
         3YXETobdfWGICBKWViqxXyOJAjqUL/0wL3FHltBXF2VU2i4/7oB5SYBvqMCFB8aj8BEu
         ftJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744023913; x=1744628713;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bOXFkEFTB5SlM6cWWhuxa7vVuGMc7ycBvnouqma9E0c=;
        b=QhFalZTAhKshOrTgAL38+JHc4Ip7C59bRGPQIFAWhMkFcx8b0IYAxqb2VgvUrmb7Vo
         yJDIkyPUTHo/HgvuQZaAojy3czMH9+U+OgWZ7hvDDbIUSR6lxjr5RvljXpBsH8IJr0pu
         04esp7CkI8Gek/NOj7KQ0mz4+5yruWtsZuf1wdfh8H2vtUQl3yTs4K/tFTr2oLKLDu/3
         RmpgZO6U1UEzwkjrW2qQYMrraC7jy0SZOoYSXPKyYXMsRAARwNiLyUkJPXzOcKG6YV3K
         JBu6z8zJIB3GnroZOv358+Gv3dL++SlR5BF/F6K84E1s5+srFpwgX+9g+7y1z81hN3y3
         v7xw==
X-Forwarded-Encrypted: i=1; AJvYcCUcpWFEKmfnaJcjaNY3V5g5RtXHkno/Wz5c8Ang0xoC+vXWbs6P5MyRksjUufBJ/GRyS2r+nlm8JQ9g@vger.kernel.org, AJvYcCUepK9kEpgpsHZMe7dnuscm46lqJo8BYESJxjXq0eFnLp3XqilO/Uql70+59oeq8gtRvbIZn18J/bs3Wq+Y@vger.kernel.org, AJvYcCX3SI51qfgf75HTAPiDJ6q8rmHY5UeF13MLfUVp6epADox4jRmonCAFmRpO7xSqSOODz/k=@vger.kernel.org, AJvYcCX3VOnQRcqc9oWfB+yx1S6iep1qnfUotjUpOCKYlJm5pTUaYB9us2TefuDJ2h7TMjfCjCgDzasSC7ksNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlnQ57SywEDauVhJpSY9Uj9j3VwTMXEXm9Io5Rl70OKekf4P7h
	Ec+S9ZntsrFPXoSXiQ8awKbaJEMaybw7/P6E3J4N8ipHPpVJyJvs
X-Gm-Gg: ASbGncsMmtM4RGqXCLWB6QGyIA2XldNKxoWJ617W6MY1Ap5G18V6lNROahpvl48ktOL
	XQsEg7UWNr+KG5HILSpUSBNX65qStDA46brZ6chtguaXaEU+9WiuUMwxfcjvgMSg9A/Al5bVQ0g
	hM8zsKwrgFJM+PdtBp7mJnZ+gHqCH0rmOF+GF+/uNIT+idK0a/dgnIyFYUfcE3B0j/7BfolXs9G
	WPYBXl+sfX2NWXhmEnwIV9kIQ5mRHiI/sQp6u2JXX0I1An8N05BiLNt99Y1fW4/FMAq/2j2w/0h
	yKjQHcDHqvQLbb3lXHVEBvb9Pn9kWx2AN/tJHoLHlpsYvtuupChW3GaKZgnSy21XrbU5ovocofx
	0abpGb8pZktcQmWROc5OXVGk9kQ==
X-Google-Smtp-Source: AGHT+IHEdeZlXLBPLb2AZowh6EoNtmvcb1ERqK3ljQe07QWdq2HbAjNeGOzM9Iopbn8UOdCKiJvXBg==
X-Received: by 2002:a05:6402:428c:b0:5f0:d853:dfec with SMTP id 4fb4d7f45d1cf-5f0d853e065mr7827782a12.13.1744023913379;
        Mon, 07 Apr 2025 04:05:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:b211:eeef:5b8c:dd2f? ([2001:b07:5d29:f42d:b211:eeef:5b8c:dd2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087eedf61sm6359409a12.32.2025.04.07.04.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:05:13 -0700 (PDT)
Message-ID: <dca6b4a3ec0c19588221205baeb55d1a424e9af6.camel@gmail.com>
Subject: Re: [RFC PATCH v2 18/22] coco/sev-guest: Implement the guest
 support for SEV TIO
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: aik@amd.com
Cc: Jonathan.Cameron@huawei.com, aneesh.kumar@kernel.org,
 ashish.kalra@amd.com,  baolu.lu@linux.intel.com, bhelgaas@google.com,
 dan.j.williams@intel.com,  dionnaglaze@google.com, hch@lst.de,
 iommu@lists.linux.dev, jgg@ziepe.ca,  joao.m.martins@oracle.com,
 joro@8bytes.org, kevin.tian@intel.com,  kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, 
 michael.roth@amd.com, nicolinc@nvidia.com, nikunj@amd.com,
 pbonzini@redhat.com,  robin.murphy@arm.com, seanjc@google.com,
 steven.sistare@oracle.com,  suravee.suthikulpanit@amd.com,
 suzuki.poulose@arm.com, thomas.lendacky@amd.com,  vasant.hegde@amd.com,
 x86@kernel.org, yi.l.liu@intel.com, yilun.xu@linux.intel.com, 
 zhiw@nvidia.com
Date: Mon, 07 Apr 2025 13:05:10 +0200
In-Reply-To: <20250218111017.491719-19-aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2025-02-18 at 11:10, Alexey Kardashevskiy wrote:
>=20
> +static int handle_tio_guest_request(struct snp_guest_dev *snp_dev,
> u8 type,
> +				   void *req_buf, size_t req_sz,
> void *resp_buf, u32 resp_sz,
> +				   void *pt, u64 *npages, u64 *bdfn,
> u64 *param, u64 *fw_err)
> +{
> +	struct snp_msg_desc *mdesc =3D snp_dev->msg_desc;
> +	struct snp_guest_req req =3D {
> +		.msg_version =3D TIO_MESSAGE_VERSION,
> +	};
> +	u64 exitinfo2 =3D 0;
> +	int ret;
> +
> +	req.msg_type =3D type;
> +	req.vmpck_id =3D mdesc->vmpck_id;
> +	req.req_buf =3D req_buf;
> +	req.req_sz =3D req_sz;
> +	req.resp_buf =3D resp_buf;
> +	req.resp_sz =3D resp_sz;
> +	req.exit_code =3D SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST;
> +
> +	req.input.guest_rid =3D 0;
> +	req.input.param =3D 0;
> +
> +	if (pt && npages) {
> +		req.data =3D pt;
> +		req.input.data_npages =3D *npages;
> +	}
> +	if (bdfn)
> +		req.input.guest_rid =3D *bdfn;
> +	if (param)
> +		req.input.param =3D *param;
> +
> +	ret =3D snp_send_guest_request(mdesc, &req, &exitinfo2);
> +
> +	if (param)
> +		*param =3D req.input.param;
> +
> +	*fw_err =3D exitinfo2;
> +
> +	return ret;

The logic to update *npages is missing.

>=20
> +}
> +
> +static int guest_request_tio_data(struct snp_guest_dev *snp_dev, u8
> type,
> +				   void *req_buf, size_t req_sz,
> void *resp_buf, u32 resp_sz,
> +				   u64 bdfn, enum tsm_tdisp_state
> *state,
> +				   struct tsm_blob **certs, struct
> tsm_blob **meas,
> +				   struct tsm_blob **report, u64
> *fw_err)
> +{
> +	u64 npages =3D SZ_32K >> PAGE_SHIFT, c1, param =3D 0;
> +	struct tio_blob_table_entry *pt;
> +	int rc;
> +
> +	pt =3D snp_alloc_shared_pages(npages << PAGE_SHIFT);
> +	if (!pt)
> +		return -ENOMEM;
> +
> +	c1 =3D npages;
> +	rc =3D handle_tio_guest_request(snp_dev, type, req_buf,
> req_sz, resp_buf, resp_sz,
> +				      pt, &c1, &bdfn, state ? &param
> : NULL, fw_err);
> +
> +	if (c1 > SZ_32K) {

c1 is supposed to be a number of pages, not a number of bytes.

> +static int tio_tdi_status(struct tsm_tdi *tdi, struct snp_guest_dev
> *snp_dev,
> +			  struct tsm_tdi_status *ts)
> +{
> +	struct snp_msg_desc *mdesc =3D snp_dev->msg_desc;
> +	size_t resp_len =3D sizeof(struct tio_msg_tdi_info_rsp) +
> mdesc->ctx->authsize;
> +	struct tio_msg_tdi_info_rsp *rsp =3D kzalloc(resp_len,
> GFP_KERNEL);
> +	struct tio_msg_tdi_info_req req =3D {
> +		.guest_device_id =3D pci_dev_id(tdi_to_pci_dev(tdi)),
> +	};
> +	u64 fw_err =3D 0;
> +	int rc;
> +	enum tsm_tdisp_state state =3D 0;
> +
> +	dev_notice(&tdi->dev, "TDI info");
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	rc =3D guest_request_tio_data(snp_dev, TIO_MSG_TDI_INFO_REQ,
> &req,
> +				     sizeof(req), rsp, resp_len,
> +				   =20
> pci_dev_id(tdi_to_pci_dev(tdi)), &state,
> +				     &tdi->tdev->certs, &tdi->tdev-
> >meas,
> +				     &tdi->report, &fw_err);
> +	if (rc)
> +		goto free_exit;
> +
> +	ts->meas_digest_valid =3D rsp->meas_digest_valid;
> +	ts->meas_digest_fresh =3D rsp->meas_digest_fresh;
> +	ts->no_fw_update =3D rsp->no_fw_update;
> +	ts->cache_line_size =3D rsp->cache_line_size =3D=3D 0 ? 64 : 128;
> +	ts->lock_msix =3D rsp->lock_msix;
> +	ts->bind_p2p =3D rsp->bind_p2p;
> +	ts->all_request_redirect =3D rsp->all_request_redirect;
> +#define __ALGO(x, n, y) \
> +	((((x) & (0xFFUL << (n))) =3D=3D TIO_SPDM_ALGOS_##y) ? \
> +	 (1ULL << TSM_SPDM_ALGOS_##y) : 0)
> +	ts->spdm_algos =3D
> +		__ALGO(rsp->spdm_algos, 0, DHE_SECP256R1) |
> +		__ALGO(rsp->spdm_algos, 0, DHE_SECP384R1) |
> +		__ALGO(rsp->spdm_algos, 8, AEAD_AES_128_GCM) |
> +		__ALGO(rsp->spdm_algos, 8, AEAD_AES_256_GCM) |
> +		__ALGO(rsp->spdm_algos, 16,
> ASYM_TPM_ALG_RSASSA_3072) |
> +		__ALGO(rsp->spdm_algos, 16,
> ASYM_TPM_ALG_ECDSA_ECC_NIST_P256) |
> +		__ALGO(rsp->spdm_algos, 16,
> ASYM_TPM_ALG_ECDSA_ECC_NIST_P384) |
> +		__ALGO(rsp->spdm_algos, 24, HASH_TPM_ALG_SHA_256) |
> +		__ALGO(rsp->spdm_algos, 24, HASH_TPM_ALG_SHA_384) |
> +		__ALGO(rsp->spdm_algos, 32,
> KEY_SCHED_SPDM_KEY_SCHEDULE);
> +#undef __ALGO
> +	memcpy(ts->certs_digest, rsp->certs_digest, sizeof(ts-
> >certs_digest));
> +	memcpy(ts->meas_digest, rsp->meas_digest, sizeof(ts-
> >meas_digest));
> +	memcpy(ts->interface_report_digest, rsp-
> >interface_report_digest,
> +	       sizeof(ts->interface_report_digest));
> +	ts->intf_report_counter =3D rsp->tdi_report_count;
> +
> +	ts->valid =3D true;
> +	ts->state =3D state;
> +	/* The response buffer contains the sensitive data,
> explicitly clear it. */
> +free_exit:
> +	memzero_explicit(&rsp, sizeof(resp_len));

The first argument should be rsp, not &rsp. This issue is also present
in the other memzero_explicit() calls in this patch.

> +static int sev_guest_tdi_validate(struct tsm_tdi *tdi, unsigned int
> featuremask,
> +				  bool invalidate, void
> *private_data)
> +{
> +	struct snp_guest_dev *snp_dev =3D private_data;
> +	struct tsm_tdi_status ts =3D { 0 };
> +	int ret;
> +
> +	if (!tdi->report) {
> +		ret =3D tio_tdi_status(tdi, snp_dev, &ts);
> +
> +		if (ret || !tdi->report) {
> +			dev_err(&tdi->dev, "No report available,
> ret=3D%d", ret);
> +			if (!ret && tdi->report)

This cannot happen, I think you meant (!ret && !tdi->report)
>=20

